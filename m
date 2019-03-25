Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717D9C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4055720863
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="c7+GU63t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCYNc1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:32:27 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:46271 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCYNc0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 09:32:26 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 6E7C4CE35;
        Mon, 25 Mar 2019 15:32:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1553520743; bh=FA6vrJSfq94Y3oVBu3vRimPP9ZqJIXwyABtZiXGi+VY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c7+GU63tO/cDaUUkm69UbQEKJO5z0eT+nlSjkE48Cop7yNIYEetipTeB4g5G5XXK4
         EVVszSMj1OwmEkGJrei/ZXR1J3PcOMZIrzdJhvBl7N9bBDptDd4Hc9og9cUYXB6XF+
         ZSnoXLjUM6MK/6T2R6sMbMjtEHihCgMP+Faqc4LjfffqyKtJmnVpbvtZ9TMgFq9MU9
         7L/TbAsemzZP1jfn23IpnFY+GHyj2JfWbAZBTGSAQTdsabUJ/Dhj8JU3iGZ4hf/+QO
         /aqCfk8L+kn32W2dBhJEMl6SbKx4KCpC6MnI1NNyc52s2Gy4R/qM5CQpE7OmbXPWXo
         D88XILPS4m4UA==
Subject: Re: [PATCH v4] PCI: qcom: Use default config space read function
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
 <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
 <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
 <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
 <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
 <29d33e81-fe8d-7fd9-843d-cc53ea6c9586@free.fr>
 <a53911a5-198a-5073-59cf-a61ba067bfd8@free.fr>
 <eb1d808e-00aa-5411-be03-2a1a8c8d655a@mm-sol.com>
 <8cd24928-54d0-c320-b53f-08332d434477@free.fr>
 <f142da4d-303a-89f3-ba5a-b6800d613e15@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <df27f753-9464-02c0-b621-d5d7b54a3403@mm-sol.com>
Date:   Mon, 25 Mar 2019 15:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f142da4d-303a-89f3-ba5a-b6800d613e15@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 3/25/19 2:11 PM, Marc Gonzalez wrote:
> Stanimir,
> 
> Is v4 good enough for Bjorn to pick up?

Yes it is good but to avoid breaking another SoCs could you add fixups
for the following SoCs:

SoC		device ID
ipq4019 	0x1001
ipq8064		0x101
ipq8074		0x108

ipq8064 has the same device ID as apq8064, but I'm not sure do we need
defines per SoC or just rename DEV_ID_8064 ? I'm fine with both ways.

> 
> Regards.
> 
> On 18/03/2019 18:14, Marc Gonzalez wrote:
> 
>> We don't need to fudge the device class in qcom_pcie_rd_own_conf()
>> because dw_pcie_setup_rc() already does the right thing:
>>
>> 	/* Program correct class for RC */
>> 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>>
>> However, the above has no effect on 8064, thus a fixup is required.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> Changes from v3 to v4: Define and use DEV_ID_8064 (not in include/linux/pci_ids.h because not shared)
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++-----------------
>>  1 file changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index d185ea5fe996..712a83354f9d 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1129,25 +1129,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>>  	return ret;
>>  }
>>  
>> -static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>> -				 u32 *val)
>> -{
>> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> -
>> -	/* the device class is not reported correctly from the register */
>> -	if (where == PCI_CLASS_REVISION && size == 4) {
>> -		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
>> -		*val &= 0xff;	/* keep revision id */
>> -		*val |= PCI_CLASS_BRIDGE_PCI << 16;
>> -		return PCIBIOS_SUCCESSFUL;
>> -	}
>> -
>> -	return dw_pcie_read(pci->dbi_base + where, size, val);
>> -}
>> -
>>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>>  	.host_init = qcom_pcie_host_init,
>> -	.rd_own_conf = qcom_pcie_rd_own_conf,
>>  };
>>  
>>  /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
>> @@ -1309,6 +1292,14 @@ static const struct of_device_id qcom_pcie_match[] = {
>>  	{ }
>>  };
>>  
>> +#define DEV_ID_8064 0x0101
>> +
>> +static void qcom_fixup_class(struct pci_dev *dev)
>> +{
>> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, DEV_ID_8064, qcom_fixup_class);
>> +
>>  static struct platform_driver qcom_pcie_driver = {
>>  	.probe = qcom_pcie_probe,
>>  	.driver = {

-- 
regards,
Stan
