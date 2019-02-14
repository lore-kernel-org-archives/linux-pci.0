Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F6C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 05:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B46222C9
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 05:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vd1hSdiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395502AbfBNFHe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:07:34 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56778 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfBNFHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Feb 2019 00:07:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E57FOn011562;
        Wed, 13 Feb 2019 23:07:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550120835;
        bh=6SQtU9RSVfN90eT8tdTGGJqFD0t1JC2r8XXu5pO7MtU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vd1hSdiTtt4iunXP/L5IW/+/WE8vS7zd90tw+QdKYy1OMPeR5DwiykZADow7RxOev
         ufcisTD5YJJxnTGfGwnzi376on+xso88wQmIDwx/sPTgOKZZWzfnmLc2tN1Xz/hdMA
         mHnjxDoDB4dnscDl0IHK19yWP1najF/E1C74faVw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E57FJV025504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 23:07:15 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 23:07:15 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 23:07:15 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E57Aju017362;
        Wed, 13 Feb 2019 23:07:11 -0600
Subject: Re: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get
 EPC features
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190107064148.10152-12-kishon@ti.com>
 <20190212150718.GA28306@e107981-ln.cambridge.arm.com>
 <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
 <20190213143646.GC25260@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4cb9ce03-e360-b518-96fd-f8a618a9c803@ti.com>
Date:   Thu, 14 Feb 2019 10:36:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213143646.GC25260@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 13/02/19 8:06 PM, Lorenzo Pieralisi wrote:
> On Wed, Feb 13, 2019 at 07:08:18PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 12/02/19 8:37 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Jan 07, 2019 at 12:11:44PM +0530, Kishon Vijay Abraham I wrote:
>>>
>>> [...]
>>>
>>>>  static int pci_epf_test_bind(struct pci_epf *epf)
>>>>  {
>>>>  	int ret;
>>>>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>>>>  	struct pci_epf_header *header = epf->header;
>>>> +	const struct pci_epc_features *epc_features;
>>>> +	enum pci_barno test_reg_bar = BAR_0;
>>>>  	struct pci_epc *epc = epf->epc;
>>>>  	struct device *dev = &epf->dev;
>>>> +	bool linkup_notifier = false;
>>>> +	bool msix_capable = false;
>>>> +	bool msi_capable = true;
>>>>  
>>>>  	if (WARN_ON_ONCE(!epc))
>>>>  		return -EINVAL;
>>>>  
>>>> -	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
>>>> -		epf_test->linkup_notifier = false;
>>>> -	else
>>>> -		epf_test->linkup_notifier = true;
>>>> -
>>>> -	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
>>>> +	epc_features = pci_epc_get_features(epc, epf->func_no);
>>>
>>> I think it would work out better if struct pci_epc_features was
>>> allocated in the caller (stack) and pci_epc_get_features() take a
>>> pointer parameter to it rather than the callee and the callee would just
>>> have to fill it out, this also removes data in the driver that is not
>>> really useful.
>>>
>>> Is there any other reason behind the current design choice ?
>>
>> Some drivers are used by multiple platforms each with different features. In
>> such cases it's cleaner to have separate epc_feature table for each platform.
>>
>> I think the driver should maintain some sort of data to even populate
>> pci_epc_features allocated by EP function driver.
> 
> You mean that every EP controller driver should keep a table of
> pci_epc_features (instead of a single instance) to be matched using DT
> compatible strings to detect the platform variations ?

Yes.

Thanks
Kishon
