Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CCFC04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E335421471
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 19:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqyFLoyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E335421471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJPDcd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:32:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53579 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPDcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 23:32:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id y11-v6so20072222wma.3;
        Mon, 15 Oct 2018 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hvpw7Ugsq4uBhd8uIUnVTPx5GMkl8VFRGm6ESBynmiU=;
        b=aqyFLoyrdwOjqQIxzH7dPOZglnlTLqUgtwzKqsHnUQCamLUmXHl59fjJ2S+ByrtLsh
         4RhCiRAyccUzJaFYHdqVIHJZI0BQrKWzXfED6HRo8I3gytCrqXlOkoHxfrqB2UN4LS0B
         4cQ5zH2GRW/TiCIsbMSA9ztLrEaN4UaFM2bNaRyzAoPUUZL5IoUz+LWgrAuLdJG5zJJs
         mvNBoHs/SMfCyu67igGwiZ2lfHG0/eHloNocvUt/tzbaUiI5q30Tohe0Vip0dNruFFZW
         322sf/zs81SVq1B6lslvG/+01qV16qUgjoNzhYY+G63YdTq3DvOp3UN29TTdD+cp2p26
         AEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hvpw7Ugsq4uBhd8uIUnVTPx5GMkl8VFRGm6ESBynmiU=;
        b=XWCrSP9M7ftYO82e8fH5M9oWZ5K6t0bL4+GQqJ60avWf1dUENOuxMUPmgujy7mnQiK
         5LQyOFFaI6VYPolVuAt8NSQSZEKBhSTWV2OaPhsmqJ/IWT/McKtwSETV75p5Rji1HAwW
         tDOfkopkl2TA5phWEC8LWAShjF07Nc8x5QOilU1V8fppI04HDobc3GOx+NJDZqiVkCJW
         /7h3tfhQGayl9Ll505Qi9lZCjhxMlhgCpGwK9LpbbzKa6FTMAApe9Ov7I59/zPXUCS9k
         JewAdQ3TFHLnr0yvU3BWrjl416HmMYAQOjyChqliLf9JHGTFJwDmNWY2QqJObrIlTryQ
         Owaw==
X-Gm-Message-State: ABuFfoi2CCDMpTmxW9xsHW9xvdfDeG0FLHYYn0vLU2CwsOU4c4vylXdc
        EVB4251Uwrl6bWw0fDlQKl0=
X-Google-Smtp-Source: ACcGV6221e3lV+WI6OqDL6M8RcWNukEW45AZtV0U94Y+Ji0Itwi08QT1JsYUefaSWYHfbUJiwqtxBw==
X-Received: by 2002:a1c:dcc:: with SMTP id 195-v6mr14013292wmn.117.1539632749681;
        Mon, 15 Oct 2018 12:45:49 -0700 (PDT)
Received: from [192.168.0.5] (cpc92304-cmbg19-2-0-cust820.5-4.cable.virginm.net. [82.24.199.53])
        by smtp.gmail.com with ESMTPSA id z8-v6sm8906812wrr.67.2018.10.15.12.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:45:48 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        jean-philippe.brucker@arm.com
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-4-jean-philippe.brucker@arm.com>
 <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Jean-philippe Brucker <jphilippe.brucker@gmail.com>
Message-ID: <6abc7321-c46a-5618-1ce7-4be85fcc38ec@gmail.com>
Date:   Mon, 15 Oct 2018 20:45:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Replying with my personal address because we're having SMTP issues]

On 12/10/2018 20:41, Bjorn Helgaas wrote:
> s/iommu/IOMMU/ in subject
> 
> On Fri, Oct 12, 2018 at 03:59:13PM +0100, Jean-Philippe Brucker wrote:
>> Using the iommu-map binding, endpoints in a given PCI domain can be
>> managed by different IOMMUs. Some virtual machines may allow a subset of
>> endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
> 
> s/case/cases/
> 
>> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
>> PCI root complex has an iommu-map property, the driver requires all
>> endpoints to be described by the property. Allow the iommu-map property to
>> have gaps.
> 
> I'm not an IOMMU or virtio expert, so it's not obvious to me why it is
> safe to allow devices to bypass the IOMMU.  Does this mean a typo in
> iommu-map could inadvertently allow devices to bypass it?

As Robin said, a device that is absent from iommu-map will be ignored by
the IOMMU layer, so it depends on the specific IOMMU implementation and
driver. By default the SMMU and virtio-iommu drivers disable bypass, but
I'm not sure about the others. I'll try to find a more accurate title for
this patch

>  Should we
> indicate something in dmesg (and/or sysfs) about devices that bypass
> it?

Good idea, I'll replace the pr_err() below with a pr_info(), instead of
simply removing it.

>> Relaxing of_pci_map_rid also allows the msi-map property to have gaps,
> 
> s/of_pci_map_rid/of_pci_map_rid()/
> 
>> which is invalid since MSIs always reach an MSI controller. Thankfully
>> Linux will error out later, when attempting to find an MSI domain for the
>> device.
> 
> Not clear to me what "error out" means here.  In a userspace program,
> I would infer that the program exits with an error message, but I
> doubt you mean that Linux exits.

Right, I'll clarify this. It's pci_msi_setup_msi_irqs() that returns an
error if the device is missing from msi-map, so the device driver won't be
able to request MSIs.

Thanks,
Jean

>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>  drivers/pci/of.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 1836b8ddf292..2f5015bdb256 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -451,9 +451,10 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
>>  		return 0;
>>  	}
>>  
>> -	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
>> -		np, map_name, rid, target && *target ? *target : NULL);
>> -	return -EFAULT;
>> +	/* Bypasses translation */
>> +	if (id_out)
>> +		*id_out = rid;
>> +	return 0;
>>  }
>>  
>>  #if IS_ENABLED(CONFIG_OF_IRQ)
>> -- 
>> 2.19.1
>>
> 

