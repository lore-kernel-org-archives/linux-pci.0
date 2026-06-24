Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFE31A572
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285108; cv=none; b=YNEK45Nmn99jjBn9Nr+ju1CSyJRD2vFsRIr9aNrTaqtN0nDeTtFB8ywQ9uiqVLJWI/eCRgxFDVM1d/a8p5fz8uCwk3isNjvHpX4w0oxw6YqbtdrvdXmBk6eNghKcgSMnIBdeJ6Ilsl4Hx0V5l9Jl4/ICECeYt/P5tGcZGf5lwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285108; c=relaxed/simple;
	bh=txS/1kRdUhTwCyDqM/4B9T0RfiIpthi5qk31Yqdjp6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=iXSSNGtEbHeMGt8gMeSk8Cbgpfbi02Ok1vwkNhjcdLkXmS88tNMgY/3EPDW39gxjkYn2xyhFe1kvDbGTaiOn+g9NkEAl79hxBii3HI4r9RLwRIzWPMbyLc2bp4yPAHcDxCFn6HwUIaLr8YkKX1kgna2Uit/fkA4+UBjvx/GBvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fRWRj2Sv; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fRWRj2Sv"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260624071143epoutp03bd0b0c5ed369ddbcac4c99642ba423f5~78tvcs4WD0428304283epoutp03D
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:11:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260624071143epoutp03bd0b0c5ed369ddbcac4c99642ba423f5~78tvcs4WD0428304283epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782285103;
	bh=zrjvf4dDUlwszH63WbRQcR2nC9N+ccUgR2HWb+avM9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRWRj2Sv4tDm4KdpF3m51UnnVrsWK1AGjj8vM+2yA6XpYgE0MM9iJmq4O1apZf/Dt
	 2pKMJLqwnRZ5a70tsQMBlnzqjdYYOujelslB5tLhqamx5pryC61ojO2xENZ2jFpb02
	 qGyCJZxG3bqe+9hPhDagi0pbGOjAltNPdlbahrTI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260624071143epcas5p40bf546f51fba20148d613d609d36c878~78tu792PI0463804638epcas5p4q;
	Wed, 24 Jun 2026 07:11:43 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4glY5V2WSgz6B9mB; Wed, 24 Jun
	2026 07:11:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260624071141epcas5p3f2ad80ffa561bfd1b7ef0df34f47c80c~78ttPKFY21139511395epcas5p3S;
	Wed, 24 Jun 2026 07:11:41 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260624071139epsmtip268e077591447c3ac8086a716c4519640~78trmQhPP0292702927epsmtip2i;
	Wed, 24 Jun 2026 07:11:39 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:30:46 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
	vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 6/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Message-ID: <20260624150046.rsmxsji4utibab66@arun-B560M-DS3H-V2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260616194619.47336bac@jic23-huawei>
X-CMS-MailID: 20260624071141epcas5p3f2ad80ffa561bfd1b7ef0df34f47c80c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_53836_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104528epcas5p4b7379fbb5bcc8ee74461a039e88b1637
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104528epcas5p4b7379fbb5bcc8ee74461a039e88b1637@epcas5p4.samsung.com>
	<20260609105836.3702787-7-shrihari.s@samsung.com>
	<20260616194619.47336bac@jic23-huawei>

------I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_53836_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/06/26 07:46PM, Jonathan Cameron wrote:
>On Tue,  9 Jun 2026 16:28:34 +0530
>Shrihari E S <shrihari.s@samsung.com> wrote:
>
>> From: Dongjoo Seo <dongjoo.seo1@samsung.com>
>>
>> Implement the PCIe Streamlined Virtual Channel (SVC) Extended
>> Capability by adding support of capability, control and status
>> registers per PCIe 6.4 section 7.9.29. This capability is one
>> of the main requisites for UIO support in both PCIe and CXL ports.
>>
>> Key changes include:
>>     - New pcie_svc.c file for SVC capability management.
>>     - Updated pcie_cap_fill_lnk() to handle flitmode signaling.
>>     - Implement Lifecycle hooks (reset and config_write) to manage
>>       SVC state.
>>
>> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
>> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
>A very quick review on this one as I'm more or less out of time for today
>(and not listening to a call ;)
>
>      pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
>> @@ -160,8 +161,14 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
>>      }
>>
>>      if (flitmode) {
>> -        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
>> +        uint32_t pos = dev->exp.exp_cap;
>> +
>> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>>                                     PCI_EXP_LNKSTA2_FLIT);
>
>Why is this writing a field from LNKSTA2 into FLAGS?
>

Hi Jonathan,

   Sorry, it's a typo. It should be PCI_EXP_LNKSTA2 instead of PCI_EXP_FLAGS.
   will correct it in the next version of patch.

>>  static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>>  {
>>      PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
>> @@ -217,7 +259,8 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>>          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
>>      }
>>
>> -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);
>> +    pcie_cap_fill_lnk(dev, exp_cap, s->width, s->speed,
>> +                      s->parent_obj.flitmode);
>
>As previously I think that should be a PCIE_PORT(s)->flitmode
>
>>  }

Yeah, will correct it.

>> +int pcie_config_uio_svc(PCIDevice *d, Error **errp)
>> +{
>> +    PCIEPort *p = PCIE_PORT(d);
>> +
>> +    if (!get_uio_mandatory_svc(p)
>> +        || pcie_svc_cap_init(d, PCI_EXT_CAP_BASE_OFFSET, errp) < 0) {
>
>|| on the line above
>

Got it, thanks for pointing out. Will correct this.

>> +int pcie_svc_cap_init(PCIDevice *dev, uint16_t offset, Error **errp)
>> +{
>> +    uint32_t hdr;
>> +
>> +    if (!pci_is_express(dev)) {
>> +        error_setg(errp, "SVC ECAP requires PCIe");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /*
>> +     * If no other ECAPs are present, make SVC the first at 0x100.
>> +     * This avoids pcie_add_capability() asserting on a non-0x100 offset.
>> +     */
>> +    hdr = pci_get_long(dev->config + PCI_CONFIG_SPACE_SIZE);
>
>Is there precedence for this?  Seems like most cases hand code
>an offset. I think letting this run has the risk that an ordering
>change might end up with this where something else wants to go.
>

Yeah, will check the precedence and change it accordingly.

>> +    if (hdr == 0) {
>> +        offset = PCI_CONFIG_SPACE_SIZE;
>> +    }
>
>
>>  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>>                                 Error **errp);
>> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
>> index 33a22229fe..644da744b2 100644
>> --- a/include/hw/pci/pcie_regs.h
>> +++ b/include/hw/pci/pcie_regs.h
>> @@ -81,6 +81,7 @@ typedef enum PCIExpLinkWidth {
>>  #define PCI_EXP_DEVCAP2_EETLPP          0x200000
>>
>>  #define PCI_EXP_DEVCTL2_EETLPPB         0x8000
>> +#define  PCI_EXP_LNKCTL_FLIT_DIS        0x2000
>
>This extra indent is supposed to associate the field with the register
>but the register isn't defined here so it makes little sense.
>
>
>>
>I see there is some precedence in here for registers that are also defined
>in the linux header that is included via hw/pci/pci_regs.h
>
>Maybe we should clean that up a t somepoint.
>
>>  /* ARI */
>>  #define PCI_ARI_VER                     1
>> diff --git a/include/hw/pci/pcie_svc.h b/include/hw/pci/pcie_svc.h
>> new file mode 100644
>> index 0000000000..4872905501
>> --- /dev/null
>> +++ b/include/hw/pci/pcie_svc.h
>> @@ -0,0 +1,91 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * PCIe Streamlined Virtual Channel (SVC) Extended Capability
>> + *
>> + * Copyright (c) 2026 Samsung Electronics Co., Ltd.
>> + */
>> +
>> +#ifndef HW_PCIE_SVC_H
>> +#define HW_PCIE_SVC_H
>
>Much of this feels like it will end up in pci_regs.h
>so maybe just do that from the start.
>

We thought that we should follow the same pattern that PCIe SRIOV did
"pcie_sriov.h", so we added pcie_svc.h. I agree that all the register
declaration and definition should go in pci_regs.h. Will do that.

>For this series you'd have to have a patch adding them with
>a note on when you expect them to be in the linux header.
>

Yeah sure.

>> +#define PCI_EXT_CAP_BASE_OFFSET                0x200
>> +#define PCI_EXT_CAP_ID_SVC                     0x35
>> +#define PCI_EXT_CAP_SVC_SIZE                   0x74
>> +
>> +/* PCIe 6.4 section 7.9.29 */
>> +#define PCIE_SVC_CAP_HEAD_OFFSET               0x00
>> +#define PCIE_SVC_CAP_OFFSET                    0x04
>
>> +#define SVC_TC_VC_MAP(n)                       ((n & 0xff) << 0)
>> +
>> +/* 7.9.27.8 SVC Resource Status Register */
>> +#define SVC_RES_STATUS_BASE                    0x1c
>> +#define SVC_RES_STATUS(n)                      (SVC_RES_STATUS_BASE + \
>> +                                                (n) * 0x0c)
>
>That's not a nice line break for readabilty. If you have two, move the whole thing to next line.
>

Sure, will rectify it.


------I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_53836_
Content-Type: text/plain; charset="utf-8"


------I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_53836_--
