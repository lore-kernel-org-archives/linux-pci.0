Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE6C43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CFB21748
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 10:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VD40MdcU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lnJkUJuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CFB21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeI1Qr4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:47:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbeI1Qr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2018 12:47:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ED52B601C3; Fri, 28 Sep 2018 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538130290;
        bh=e2930RuRGRDxseH0ZAU/fTYMEHKLX9fSJsqkV0DkHJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VD40MdcUzebaR3zFJ6hcXROnKM7Cdt2acV21uVJALsze1OjgbcL88Cu+SYmfhPrCJ
         LH0zQfeDzi+ZA3HpvI7y6+IxwoIS9VPBl2CKoVLtMb1s58f9iXEy95GaRoDRwdYyIg
         0bpIx+JDb4KkUMW4ZJxfr6Z4g4uycFudFiq3SzTw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B458D60588;
        Fri, 28 Sep 2018 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538130286;
        bh=e2930RuRGRDxseH0ZAU/fTYMEHKLX9fSJsqkV0DkHJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lnJkUJuB76SsewR0frdD3yKAFtljtlRnTOGp/hSR3Bk3DdcI+RDcVrO/plPoKRyVb
         OYtYtkyGgv3ANAD/xECEfKcF6gQQN9dEPpRzZSsN+8dLOgkMu2x2YwxOymXTWz8zwU
         6tjFt9F502JSOQjc0Pfc/rsmr8wFQOw+v/ZvkV4A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Sep 2018 15:54:45 +0530
From:   poza@codeaurora.org
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Wei Zhang <wzhang@fb.com>, linux-kernel@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] PCI/AER: Clear uncorrectable error status for device
In-Reply-To: <20180926220848.GK28024@bhelgaas-glaptop.roam.corp.google.com>
References: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
 <20180926220848.GK28024@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <605a3c5d65ae2f42237c7258a6c3e21b@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018-09-27 03:38, Bjorn Helgaas wrote:
> [+cc Sinan, LKML]
> 
> On Tue, Sep 18, 2018 at 04:20:29AM -0400, Oza Pawandeep wrote:
>> PCI based device drivers handles ERR_NONFATAL  by registering
>> pci_error_handlers. some of the drivers clear AER uncorrectable status
>> in slot_reset while some in resume.
>> 
>> Drivers should not have responsibility of clearing the AER status, 
>> instead
>> shall be done by error and recovery framework defined in err.c
> 
> Agreed, and Keith's patch 43c9a34fe04e ("PCI/ERR: Always use the first
> downstream port") [1], which is queued on pci/hotplug for v4.20, does
> call pci_cleanup_aer_uncorrect_error_status() at the end of
> pcie_do_recovery().
> 
> 1) Does that seem like the right place?
> 
> 2) I guess all we need now would be to remove the calls from the
>    drivers?
> 
> 3) If we remove all the calls from the drivers, we should remove the
>    declaration from include/linux/aer.h, too.
> 
> I can take care of these updates if we agree they're the right thing
> to do.

sure Bjorn. this patch already removes all the calls from drivers and 
adds
call to pci_cleanup_aer_uncorrect_error_status().

Please feel free to modify or adapt and take care.

Regards,
Oza.

> 
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=43c9a34fe04e
> 
>> Clear the status while resuming, after reset_link was successful.
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/crypto/qat/qat_common/adf_aer.c 
>> b/drivers/crypto/qat/qat_common/adf_aer.c
>> index da8a2d3..61ded36 100644
>> --- a/drivers/crypto/qat/qat_common/adf_aer.c
>> +++ b/drivers/crypto/qat/qat_common/adf_aer.c
>> @@ -198,7 +198,6 @@ static pci_ers_result_t adf_slot_reset(struct 
>> pci_dev *pdev)
>>  		pr_err("QAT: Can't find acceleration device\n");
>>  		return PCI_ERS_RESULT_DISCONNECT;
>>  	}
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	if (adf_dev_aer_schedule_reset(accel_dev, ADF_DEV_RESET_SYNC))
>>  		return PCI_ERS_RESULT_DISCONNECT;
>> 
>> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
>> index 4fa4c06..80c475f 100644
>> --- a/drivers/dma/ioat/init.c
>> +++ b/drivers/dma/ioat/init.c
>> @@ -1267,12 +1267,6 @@ static pci_ers_result_t 
>> ioat_pcie_error_slot_reset(struct pci_dev *pdev)
>>  		pci_wake_from_d3(pdev, false);
>>  	}
>> 
>> -	err = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (err) {
>> -		dev_err(&pdev->dev,
>> -			"AER uncorrect error status clear failed: %#x\n", err);
>> -	}
>> -
>>  	return result;
>>  }
>> 
>> diff --git a/drivers/infiniband/hw/hfi1/pcie.c 
>> b/drivers/infiniband/hw/hfi1/pcie.c
>> index baf7c32..38bc804 100644
>> --- a/drivers/infiniband/hw/hfi1/pcie.c
>> +++ b/drivers/infiniband/hw/hfi1/pcie.c
>> @@ -655,7 +655,6 @@ pci_resume(struct pci_dev *pdev)
>>  	struct hfi1_devdata *dd = pci_get_drvdata(pdev);
>> 
>>  	dd_dev_info(dd, "HFI1 resume function called\n");
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	/*
>>  	 * Running jobs will fail, since it's asynchronous
>>  	 * unlike sysfs-requested reset.   Better than
>> diff --git a/drivers/infiniband/hw/qib/qib_pcie.c 
>> b/drivers/infiniband/hw/qib/qib_pcie.c
>> index 5ac7b31..30595b3 100644
>> --- a/drivers/infiniband/hw/qib/qib_pcie.c
>> +++ b/drivers/infiniband/hw/qib/qib_pcie.c
>> @@ -597,7 +597,6 @@ qib_pci_resume(struct pci_dev *pdev)
>>  	struct qib_devdata *dd = pci_get_drvdata(pdev);
>> 
>>  	qib_devinfo(pdev, "QIB resume function called\n");
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	/*
>>  	 * Running jobs will fail, since it's asynchronous
>>  	 * unlike sysfs-requested reset.   Better than
>> diff --git a/drivers/net/ethernet/atheros/alx/main.c 
>> b/drivers/net/ethernet/atheros/alx/main.c
>> index 567ee54..0d0b6a4 100644
>> --- a/drivers/net/ethernet/atheros/alx/main.c
>> +++ b/drivers/net/ethernet/atheros/alx/main.c
>> @@ -1960,8 +1960,6 @@ static pci_ers_result_t 
>> alx_pci_error_slot_reset(struct pci_dev *pdev)
>>  	if (!alx_reset_mac(hw))
>>  		rc = PCI_ERS_RESULT_RECOVERED;
>>  out:
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> -
>>  	rtnl_unlock();
>> 
>>  	return rc;
>> diff --git a/drivers/net/ethernet/broadcom/bnx2.c 
>> b/drivers/net/ethernet/broadcom/bnx2.c
>> index 122fdb8..bbb2471 100644
>> --- a/drivers/net/ethernet/broadcom/bnx2.c
>> +++ b/drivers/net/ethernet/broadcom/bnx2.c
>> @@ -8793,13 +8793,6 @@ static pci_ers_result_t 
>> bnx2_io_slot_reset(struct pci_dev *pdev)
>>  	if (!(bp->flags & BNX2_FLAG_AER_ENABLED))
>>  		return result;
>> 
>> -	err = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (err) {
>> -		dev_err(&pdev->dev,
>> -			"pci_cleanup_aer_uncorrect_error_status failed 0x%0x\n",
>> -			 err); /* non-fatal, continue */
>> -	}
>> -
>>  	return result;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c 
>> b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
>> index 5b1ed24..cfb6c89 100644
>> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
>> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
>> @@ -14379,14 +14379,6 @@ static pci_ers_result_t 
>> bnx2x_io_slot_reset(struct pci_dev *pdev)
>> 
>>  	rtnl_unlock();
>> 
>> -	/* If AER, perform cleanup of the PCIe registers */
>> -	if (bp->flags & AER_ENABLED) {
>> -		if (pci_cleanup_aer_uncorrect_error_status(pdev))
>> -			BNX2X_ERR("pci_cleanup_aer_uncorrect_error_status failed\n");
>> -		else
>> -			DP(NETIF_MSG_HW, "pci_cleanup_aer_uncorrect_error_status 
>> succeeded\n");
>> -	}
>> -
>>  	return PCI_ERS_RESULT_RECOVERED;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c 
>> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 176fc9f..b4d1db9 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -9076,13 +9076,6 @@ static pci_ers_result_t 
>> bnxt_io_slot_reset(struct pci_dev *pdev)
>> 
>>  	rtnl_unlock();
>> 
>> -	err = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (err) {
>> -		dev_err(&pdev->dev,
>> -			"pci_cleanup_aer_uncorrect_error_status failed 0x%0x\n",
>> -			 err); /* non-fatal, continue */
>> -	}
>> -
>>  	return PCI_ERS_RESULT_RECOVERED;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c 
>> b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> index dd04a2f..b6c1478a 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> @@ -4721,7 +4721,6 @@ static pci_ers_result_t eeh_slot_reset(struct 
>> pci_dev *pdev)
>>  	pci_set_master(pdev);
>>  	pci_restore_state(pdev);
>>  	pci_save_state(pdev);
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> 
>>  	if (t4_wait_dev_ready(adap->regs) < 0)
>>  		return PCI_ERS_RESULT_DISCONNECT;
>> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c 
>> b/drivers/net/ethernet/emulex/benet/be_main.c
>> index 8f75500..c274006 100644
>> --- a/drivers/net/ethernet/emulex/benet/be_main.c
>> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
>> @@ -6063,7 +6063,6 @@ static pci_ers_result_t be_eeh_reset(struct 
>> pci_dev *pdev)
>>  	if (status)
>>  		return PCI_ERS_RESULT_DISCONNECT;
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	be_clear_error(adapter, BE_CLEAR_ALL);
>>  	return PCI_ERS_RESULT_RECOVERED;
>>  }
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 3ba0c90..7cd2332 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -6854,8 +6854,6 @@ static pci_ers_result_t 
>> e1000_io_slot_reset(struct pci_dev *pdev)
>>  		result = PCI_ERS_RESULT_RECOVERED;
>>  	}
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> -
>>  	return result;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c 
>> b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> index 15071e4..55138d6 100644
>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
>> @@ -2462,8 +2462,6 @@ static pci_ers_result_t 
>> fm10k_io_slot_reset(struct pci_dev *pdev)
>>  		result = PCI_ERS_RESULT_RECOVERED;
>>  	}
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> -
>>  	return result;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c 
>> b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index c944bd1..ae6aef2 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -14245,14 +14245,6 @@ static pci_ers_result_t 
>> i40e_pci_error_slot_reset(struct pci_dev *pdev)
>>  			result = PCI_ERS_RESULT_DISCONNECT;
>>  	}
>> 
>> -	err = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (err) {
>> -		dev_info(&pdev->dev,
>> -			 "pci_cleanup_aer_uncorrect_error_status failed 0x%0x\n",
>> -			 err);
>> -		/* non-fatal, continue */
>> -	}
>> -
>>  	return result;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c 
>> b/drivers/net/ethernet/intel/igb/igb_main.c
>> index c77fda0..786b973 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -8991,7 +8991,6 @@ static pci_ers_result_t igb_io_slot_reset(struct 
>> pci_dev *pdev)
>>  	struct igb_adapter *adapter = netdev_priv(netdev);
>>  	struct e1000_hw *hw = &adapter->hw;
>>  	pci_ers_result_t result;
>> -	int err;
>> 
>>  	if (pci_enable_device_mem(pdev)) {
>>  		dev_err(&pdev->dev,
>> @@ -9015,14 +9014,6 @@ static pci_ers_result_t 
>> igb_io_slot_reset(struct pci_dev *pdev)
>>  		result = PCI_ERS_RESULT_RECOVERED;
>>  	}
>> 
>> -	err = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (err) {
>> -		dev_err(&pdev->dev,
>> -			"pci_cleanup_aer_uncorrect_error_status failed 0x%0x\n",
>> -			err);
>> -		/* non-fatal, continue */
>> -	}
>> -
>>  	return result;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c 
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 3e87dbb..a2f8ce9 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -10864,8 +10864,6 @@ static pci_ers_result_t 
>> ixgbe_io_error_detected(struct pci_dev *pdev,
>>  			/* Free device reference count */
>>  			pci_dev_put(vfdev);
>>  		}
>> -
>> -		pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	}
>> 
>>  	/*
>> @@ -10935,13 +10933,6 @@ static pci_ers_result_t 
>> ixgbe_io_slot_reset(struct pci_dev *pdev)
>>  		result = PCI_ERS_RESULT_RECOVERED;
>>  	}
>> 
>> -	err = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (err) {
>> -		e_dev_err("pci_cleanup_aer_uncorrect_error_status "
>> -			  "failed 0x%0x\n", err);
>> -		/* non-fatal, continue */
>> -	}
>> -
>>  	return result;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c 
>> b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
>> index 8259e83..d0d276c 100644
>> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
>> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
>> @@ -1790,11 +1790,6 @@ static pci_ers_result_t 
>> netxen_io_slot_reset(struct pci_dev *pdev)
>>  	return err ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>>  }
>> 
>> -static void netxen_io_resume(struct pci_dev *pdev)
>> -{
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> -}
>> -
>>  static void netxen_nic_shutdown(struct pci_dev *pdev)
>>  {
>>  	struct netxen_adapter *adapter = pci_get_drvdata(pdev);
>> @@ -3490,7 +3485,6 @@ netxen_free_ip_list(struct netxen_adapter 
>> *adapter, bool master)
>>  static const struct pci_error_handlers netxen_err_handler = {
>>  	.error_detected = netxen_io_error_detected,
>>  	.slot_reset = netxen_io_slot_reset,
>> -	.resume = netxen_io_resume,
>>  };
>> 
>>  static struct pci_driver netxen_driver = {
>> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c 
>> b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
>> index 569d54e..635ac73 100644
>> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
>> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
>> @@ -4232,7 +4232,6 @@ static void qlcnic_83xx_io_resume(struct pci_dev 
>> *pdev)
>>  {
>>  	struct qlcnic_adapter *adapter = pci_get_drvdata(pdev);
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	if (test_and_clear_bit(__QLCNIC_AER, &adapter->state))
>>  		qlcnic_83xx_aer_start_poll_work(adapter);
>>  }
>> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c 
>> b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
>> index 2d38d1a..6b3ea53 100644
>> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
>> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
>> @@ -3975,7 +3975,6 @@ static void qlcnic_82xx_io_resume(struct pci_dev 
>> *pdev)
>>  	u32 state;
>>  	struct qlcnic_adapter *adapter = pci_get_drvdata(pdev);
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	state = QLC_SHARED_REG_RD32(adapter, QLCNIC_CRB_DEV_STATE);
>>  	if (state == QLCNIC_DEV_READY && test_and_clear_bit(__QLCNIC_AER,
>>  							    &adapter->state))
>> diff --git a/drivers/net/ethernet/sfc/efx.c 
>> b/drivers/net/ethernet/sfc/efx.c
>> index ad4a354..72c63ee 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -3843,13 +3843,6 @@ static pci_ers_result_t 
>> efx_io_slot_reset(struct pci_dev *pdev)
>>  		status =  PCI_ERS_RESULT_DISCONNECT;
>>  	}
>> 
>> -	rc = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (rc) {
>> -		netif_err(efx, hw, efx->net_dev,
>> -		"pci_cleanup_aer_uncorrect_error_status failed (%d)\n", rc);
>> -		/* Non-fatal error. Continue. */
>> -	}
>> -
>>  	return status;
>>  }
>> 
>> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c 
>> b/drivers/net/ethernet/sfc/falcon/efx.c
>> index dd5530a..1b394ea 100644
>> --- a/drivers/net/ethernet/sfc/falcon/efx.c
>> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
>> @@ -3194,13 +3194,6 @@ static pci_ers_result_t 
>> ef4_io_slot_reset(struct pci_dev *pdev)
>>  		status =  PCI_ERS_RESULT_DISCONNECT;
>>  	}
>> 
>> -	rc = pci_cleanup_aer_uncorrect_error_status(pdev);
>> -	if (rc) {
>> -		netif_err(efx, hw, efx->net_dev,
>> -		"pci_cleanup_aer_uncorrect_error_status failed (%d)\n", rc);
>> -		/* Non-fatal error. Continue. */
>> -	}
>> -
>>  	return status;
>>  }
>> 
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index fc33804..9f9ff21 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2678,7 +2678,6 @@ static void nvme_error_resume(struct pci_dev 
>> *pdev)
>>  	struct nvme_dev *dev = pci_get_drvdata(pdev);
>> 
>>  	flush_work(&dev->ctrl.reset_work);
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  }
>> 
>>  static const struct pci_error_handlers nvme_err_handler = {
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 44598dc..81d65bf 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -265,6 +265,8 @@ static pci_ers_result_t 
>> broadcast_error_message(struct pci_dev *dev,
>>  		 * The error is non fatal so the bus is ok; just invoke
>>  		 * the callback for the function that logged the error.
>>  		 */
>> +		if (cb == report_resume)
>> +			pci_cleanup_aer_uncorrect_error_status(dev);
>>  		cb(dev, &result_data);
>>  	}
>> 
>> diff --git a/drivers/scsi/aacraid/linit.c 
>> b/drivers/scsi/aacraid/linit.c
>> index 0444357..1bcdd50 100644
>> --- a/drivers/scsi/aacraid/linit.c
>> +++ b/drivers/scsi/aacraid/linit.c
>> @@ -2055,8 +2055,6 @@ static void aac_pci_resume(struct pci_dev *pdev)
>>  	struct scsi_device *sdev = NULL;
>>  	struct aac_dev *aac = (struct aac_dev *)shost_priv(shost);
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> -
>>  	if (aac_adapter_ioremap(aac, aac->base_size)) {
>> 
>>  		dev_err(&pdev->dev, "aacraid: ioremap failed\n");
>> diff --git a/drivers/scsi/be2iscsi/be_main.c 
>> b/drivers/scsi/be2iscsi/be_main.c
>> index 818d185..ed7ed15 100644
>> --- a/drivers/scsi/be2iscsi/be_main.c
>> +++ b/drivers/scsi/be2iscsi/be_main.c
>> @@ -5518,7 +5518,6 @@ static pci_ers_result_t beiscsi_eeh_reset(struct 
>> pci_dev *pdev)
>>  		return PCI_ERS_RESULT_DISCONNECT;
>>  	}
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	return PCI_ERS_RESULT_RECOVERED;
>>  }
>> 
>> diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
>> index bd7e6a6f..911efc9 100644
>> --- a/drivers/scsi/bfa/bfad.c
>> +++ b/drivers/scsi/bfa/bfad.c
>> @@ -1569,8 +1569,6 @@ bfad_pci_slot_reset(struct pci_dev *pdev)
>>  		if (pci_set_dma_mask(bfad->pcidev, DMA_BIT_MASK(32)) != 0)
>>  			goto out_disable_device;
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> -
>>  	if (restart_bfa(bfad) == -1)
>>  		goto out_disable_device;
>> 
>> diff --git a/drivers/scsi/csiostor/csio_init.c 
>> b/drivers/scsi/csiostor/csio_init.c
>> index ed2dae6..66b230b 100644
>> --- a/drivers/scsi/csiostor/csio_init.c
>> +++ b/drivers/scsi/csiostor/csio_init.c
>> @@ -1102,7 +1102,6 @@ csio_pci_slot_reset(struct pci_dev *pdev)
>>  	pci_set_master(pdev);
>>  	pci_restore_state(pdev);
>>  	pci_save_state(pdev);
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> 
>>  	/* Bring HW s/m to ready state.
>>  	 * but don't resume IOs.
>> diff --git a/drivers/scsi/lpfc/lpfc_init.c 
>> b/drivers/scsi/lpfc/lpfc_init.c
>> index 52cae87..305ea062 100644
>> --- a/drivers/scsi/lpfc/lpfc_init.c
>> +++ b/drivers/scsi/lpfc/lpfc_init.c
>> @@ -11331,10 +11331,6 @@ lpfc_io_resume_s3(struct pci_dev *pdev)
>> 
>>  	/* Bring device online, it will be no-op for non-fatal error resume 
>> */
>>  	lpfc_online(phba);
>> -
>> -	/* Clean up Advanced Error Reporting (AER) if needed */
>> -	if (phba->hba_flag & HBA_AER_ENABLED)
>> -		pci_cleanup_aer_uncorrect_error_status(pdev);
>>  }
>> 
>>  /**
>> @@ -12146,10 +12142,6 @@ lpfc_io_resume_s4(struct pci_dev *pdev)
>>  		/* Bring the device back online */
>>  		lpfc_online(phba);
>>  	}
>> -
>> -	/* Clean up Advanced Error Reporting (AER) if needed */
>> -	if (phba->hba_flag & HBA_AER_ENABLED)
>> -		pci_cleanup_aer_uncorrect_error_status(pdev);
>>  }
>> 
>>  /**
>> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c 
>> b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
>> index b8d131a..602f659 100644
>> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
>> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
>> @@ -10965,7 +10965,6 @@ scsih_pci_resume(struct pci_dev *pdev)
>> 
>>  	pr_info(MPT3SAS_FMT "PCI error: resume callback!!\n", ioc->name);
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	mpt3sas_base_start_watchdog(ioc);
>>  	scsi_unblock_requests(ioc->shost);
>>  }
>> diff --git a/drivers/scsi/qla2xxx/qla_os.c 
>> b/drivers/scsi/qla2xxx/qla_os.c
>> index e881fce..5fc1a49 100644
>> --- a/drivers/scsi/qla2xxx/qla_os.c
>> +++ b/drivers/scsi/qla2xxx/qla_os.c
>> @@ -6823,8 +6823,6 @@ qla2xxx_pci_resume(struct pci_dev *pdev)
>>  		    "The device failed to resume I/O from slot/link_reset.\n");
>>  	}
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>> -
>>  	ha->flags.eeh_busy = 0;
>>  }
>> 
>> diff --git a/drivers/scsi/qla4xxx/ql4_os.c 
>> b/drivers/scsi/qla4xxx/ql4_os.c
>> index 0e13349..ab3a924 100644
>> --- a/drivers/scsi/qla4xxx/ql4_os.c
>> +++ b/drivers/scsi/qla4xxx/ql4_os.c
>> @@ -9824,7 +9824,6 @@ qla4xxx_pci_resume(struct pci_dev *pdev)
>>  		     __func__);
>>  	}
>> 
>> -	pci_cleanup_aer_uncorrect_error_status(pdev);
>>  	clear_bit(AF_EEH_BUSY, &ha->flags);
>>  }
>> 
>> --
>> 2.7.4
>> 
