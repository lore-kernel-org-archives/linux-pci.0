Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FEC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 05:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E92B222C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 05:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JVpHw7KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfBMFXa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 00:23:30 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14731 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfBMFXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 00:23:30 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c63a9d10000>; Tue, 12 Feb 2019 21:23:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2019 21:23:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Feb 2019 21:23:28 -0800
Received: from [10.25.73.1] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Feb
 2019 05:23:24 +0000
Subject: Re: [PATCH v1 2/2] PCI/ASPM: Save LTR Capability for suspend/resume
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     RussianNeuroMancer <russianneuromancer@ya.ru>,
        David Ward <david.ward@ll.mit.edu>,
        Frederick Lawler <fred@fredlawl.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <154992574559.7864.8459750458248568194.stgit@bhelgaas-glaptop.roam.corp.google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <5096dec8-e735-1c7e-c7cd-760d13e124f2@nvidia.com>
Date:   Wed, 13 Feb 2019 10:53:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154992574559.7864.8459750458248568194.stgit@bhelgaas-glaptop.roam.corp.google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550035409; bh=EZtfXVoD8VPj6iaVuj3MlIpiYeC5TniqPYNtthXluR8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=JVpHw7KGyUpU/joEG4n7LI0MXe1N42Z0uYXBHIg1Bu97ovyCbFZv/11w+VL8Lwbck
         YkuJ91ljo6CKTnY7taaZXLelgbhuF0MIXf58OhL1ylHe+hJEbsUPfc/5UL2tJ/gQJP
         qNZtClvA44j0mpIlcAx2ng4mvoNkcroJMrI55rKBKxM2tescqWw9lu8cwF231Sa9jM
         nfmDABCDmBdYq4snebi+Z9XKmNbBkolNzM9j/Bf42HioyGoEcRT5xxwnQTwS2HGbIC
         +7WAXlJ4kBhOj0XXSenWneB4qUws9v6jepkTfh5ERYpOvfye5qeym2hfldem2Mt4G+
         0t92kouypAh6g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/12/2019 4:25 AM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Latency Tolerance Reporting (LTR) allows Endpoints and Switch Upstream
> Ports to report their latency requirements to upstream components.  If ASPM
> L1 PM substates are enabled, the LTR information helps determine when a
> Link enters L1.2 [1].
>
> Software must set the maximum latency values in the LTR Capability based on
> characteristics of the platform, then set LTR Mechanism Enable in the
> Device Control 2 register in the PCIe Capability.  The device can then use
> LTR to report its latency tolerance.
>
> If the device reports a maximum latency value of zero, that means the
> device requires the highest possible performance and the ASPM L1.2 substate
> is effectively disabled.
>
> We put devices in D3 for suspend, and we assume their internal state is
> lost.  On resume, previously we did not restore the LTR Capability, but we
> did restore the LTR Mechanism Enable bit, so devices would request the
> highest possible performance and ASPM L1.2 wouldn't be used.
>
> [1] PCIe r4.0, sec 5.5.1
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201469
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pci.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c9d8e3c837de..13d65991c77b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1233,7 +1233,6 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>   	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
>   }
>   
> -
>   static int pci_save_pcix_state(struct pci_dev *dev)
>   {
>   	int pos;
> @@ -1270,6 +1269,45 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
>   	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
>   }
>   
> +static void pci_save_ltr_state(struct pci_dev *dev)
> +{
> +	int ltr;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
> +	if (!ltr)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	if (!save_state) {
> +		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
> +		return;
> +	}
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap++);
> +	pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, cap++);
> +}
> +
> +static void pci_restore_ltr_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int ltr;
> +	u16 *cap;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
> +	if (!save_state || !ltr)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++);
> +	pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
> +}
>   
>   /**
>    * pci_save_state - save the PCI configuration space of a device before suspending
> @@ -1291,6 +1329,7 @@ int pci_save_state(struct pci_dev *dev)
>   	if (i != 0)
>   		return i;
>   
> +	pci_save_ltr_state(dev);
>   	pci_save_dpc_state(dev);
>   	return pci_save_vc_state(dev);
>   }
> @@ -1390,7 +1429,12 @@ void pci_restore_state(struct pci_dev *dev)
>   	if (!dev->state_saved)
>   		return;
>   
> -	/* PCI Express register must be restored first */
> +	/*
> +	 * Restore max latencies (in the LTR capability) before enabling
> +	 * LTR itself (in the PCIe capability).
> +	 */
> +	pci_restore_ltr_state(dev);
> +
>   	pci_restore_pcie_state(dev);
>   	pci_restore_pasid_state(dev);
>   	pci_restore_pri_state(dev);
> @@ -2998,6 +3042,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>   	if (error)
>   		pci_err(dev, "unable to preallocate PCI-X save buffer\n");
>   
> +	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
> +					    2 * sizeof(u16));
> +	if (error)
> +		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> +
>   	pci_allocate_vc_save_buffers(dev);
>   }
Don't we have to save and restore L1SS control registers (PCI_L1SS_CTL1 
& PCI_L1SS_CTL2) as well?
>   
>
