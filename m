Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D3281357
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771996884; cv=pass; b=I/x0GrcP5ZwvnLWS/9M6ZLIYqsfhLGALcHHF6hIbJB+y1XlomzbzRNiKUqczwP4Hltyr8SgEIsBeaPM9jocXN9PW+FLahQgxDtP0QDrL547+C4qwTJJmZlqlFQq6+wbKojXRLTt0xDADcBRPWqLQ7cXe8xIqpX1+Z9ffW5br2mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771996884; c=relaxed/simple;
	bh=no5EgKxT37sHSxh65x/itckUFlueTX70grjul+hXFuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdWuUXnUzxVO7hyz+pWPrABleJfzusTv2EzWKnfWfrb/zZHLC0ACkux2ppN1SQyXeUgYC4eIvtD8ezaQVnMukJ/iyQxO1rf/MxUwde1+0Hab852QaEocuwiKTpFwM1IAriUMmAMKVAHI3lNG19EovNVHIerMEoHy6OrpXUG1weQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UT3BYpxN; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UT3BYpxN"
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B6BC33F2AF
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 05:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1771996873;
	bh=MC+0NNgbi/K/QP35P5O4s/8rtyImFnr1erlyFQnnOWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=UT3BYpxNj72mkcUAadhfcIoZO5XdPOcvU530+peF2It5bkiVzGC+/Ex9y/Xkcyc2L
	 YE2lYdcqTSJOMDJD0b++MgKn+4KIsJQT4rq9iXulx2uSGrxixabtQ6q1GFDc/0jSgG
	 rDJq2d7S2WCEBh0rmoAlT2b+r8RXbqW3Ncej97vT/cY4CDEV0+GSENPfzcYkDfWfoa
	 UzI26fu5V7b4KPSemyVgkT8JLNkVkvBlS33qAlNl4QMpAolMPDJ1ABTm47Tsab3Mvr
	 DuumnAi47KyHL1nOCDNrGgX3jyQvzJOEO0Y9ba+LWIJs/3HhNd9s/KwM5MIymKqD87
	 LdyCLVe4+eIlSWOdSnEzIOkwbDmK3Bz7r0DidieUVny1flgooh2B0XMgohjiE2mRJN
	 tIbb95ZUuZWrnkTbqLxRMbSsmBm/roY8tpF/sBJDoYZ3w7ubA/ENjFbSEPh+ahE9dr
	 Q4nNsIKLpS6bwKDmBDodoMf87USQRE1WY/Stk06gxXZ2dT10BQZFPWHNM8A3A/+dNN
	 P+SaOcXoYHODPea5NF5X4mSyOMrGDXtA20wH2y1s8F+8Xn68+zf+v26xWZZ6/XcvhY
	 lg53eTpneg9B4GV7WziBNgPOHHyApKuVgGVDSn6FroynP8sZloKGpw6NtdQOCbeQxn
	 xxcrjqlt55XY9idqeR21LnLg=
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-644548b1dcfso10493037d50.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 21:21:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771996872; cv=none;
        d=google.com; s=arc-20240605;
        b=c4XuDhsf3w8Pmp++RSpEpnoFucB93L1H4yA8XpK2oIlRURjuMmeDK0K7DINEsdV3y2
         t1hVYugEiVqSkZhTWcAlQfgjFCFWns/O+JhWceMjEFlABYN5gyAz6rLvU8RuSEYe6PgA
         kWhYYtFB6lwQzUF6ntxiPe/O+IWKUZREdd+fGSgfUfEIv1+8WRMTj/H0fH32tI83vYe7
         iCd64QToAwST/JMxMX/PgeV553T5ncQf0MwmjAOREmdnvhvc+v28J0dkT7cFYgVRhdIg
         YBIqWuylP3BY4Xh2EXz10rPa84yqZU2XxzdoRQNspjsoZaOokFej7F1gBuCb9HXiuYmH
         Z38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=MC+0NNgbi/K/QP35P5O4s/8rtyImFnr1erlyFQnnOWU=;
        fh=5jhDIeSNX0LUh1X6im7ZlQ5oUnslVbisDQtvUNbQBQA=;
        b=VIoXj9eaadrq7iSM9Ke7TYNWXZdd0+h+qQpSLiVTFKgGBqxhnLOKJgUvCp1WCbe/ZS
         9+/v9ZNSZgh/ZOxbBMxcZJCavLTj2i6o0pUoqkprlmrr13i1TJhCB6p0O9n9+wCK8N6b
         GAXBzlsj/lRfh2jivp6QOsSCWvgcp/dscc+JIyEEGflozMeoEs6fltmL+kUnIanr+oxh
         yq8BWAYCMC6yJPiTqpAX2gzZx2tOiQXoxGnk6S8v1SeIU9W2GVH1Oo7hSHZEq0kI1/+B
         IhdhAMM9Ha2/x4Dx2ZOvEVLylYQV9i0RRxXbGtwXmGlzsGb2GfuL1rTiTau71FmnYRjA
         6e+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771996872; x=1772601672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC+0NNgbi/K/QP35P5O4s/8rtyImFnr1erlyFQnnOWU=;
        b=WE6mHyN1KMn5K/fqjz9arqv3An0+gv0lm9/P6rLPoqsS7UBn8nOuF4fL2dN1LchxEx
         ycla6oRY/HrVDQu69toOX4+oYquqnu4sJBoxlUj6l7vUXvV9kLlO/p/hycUwjuHVeCC7
         5n0XlsqZ/GCQzeCvHU9PhQaXQSRGVKPFBeYxN8Wwr1nFVvAkDFN1DnG51NMoVEE+8tHZ
         fq+jpkXPr5hAVLQvA/yRJO2eAt0V537n4YGTC4rPnyz//TSljU0+70E5SPdvNEMEPK16
         0GBklV/w2n6wWV/hAl1sWFuRf1+OQIy8ambX983IA9nhSlX3JwLR6kPW32bO46OHPhiG
         UjZg==
X-Forwarded-Encrypted: i=1; AJvYcCXOqYsFUHIdO846Uj6OJJZ1MBK/IVH4FQyF86Py3T3W2dqEQHN9soHh528rnuNZEtXMaLW4Kgy2538=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrdkM2ekS77hMS41r02SCTQbYkOVzPvj23VhCdCstpS1LUGat6
	MbhNd2gY44S9hHa9xCTEkB5+EdCkfdVYoiAk6zYmZN7dAPchA7Gw34O2WoNUt62kIGSHOBQOaQa
	tUR2Udi8X8rMkou9pa/x42uqLweLKUX45oWMBR0OD6IJ40150WzJTeZRhrzvh0Y2yZS02Qd+qg7
	a6irTLabz3SaE2WXj3URvEguX7zV+IfSgnK9FlAq9OGOwYi0UuDB3ij4YVIEalyf0=
X-Gm-Gg: ATEYQzx3yowIRTCZyA1+C3Ii/qApxf7VDcmzSo7H7UbN72l0cVFyd6gsMnDU2hdpoM5
	ICcYPOVCelewl4VPWxj9rNtCnFPA2aCnKr0rW153hy9b2qgyaVegwspyJW31TDM7vrlmnbiYXGS
	HnjPkaXDvhHbLvYlxVskOUldgOkam8jdzYtyIDILtUwSPOIRKump4D1rNZLoPK9wHGd5My/02QR
	nMPdQ==
X-Received: by 2002:a05:690e:16cd:b0:64c:a5f9:9b2d with SMTP id 956f58d0204a3-64ca5f99b88mr1743693d50.21.1771996872522;
        Tue, 24 Feb 2026 21:21:12 -0800 (PST)
X-Received: by 2002:a05:690e:16cd:b0:64c:a5f9:9b2d with SMTP id
 956f58d0204a3-64ca5f99b88mr1743686d50.21.1771996872224; Tue, 24 Feb 2026
 21:21:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213192607.GA3167656@bhelgaas> <a7d03703-04fa-4c26-987a-a34d2e96a4a7@amd.com>
 <842e6a0a-1288-4b79-88a9-f866d38292f1@amd.com>
In-Reply-To: <842e6a0a-1288-4b79-88a9-f866d38292f1@amd.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Wed, 25 Feb 2026 18:21:01 +1300
X-Gm-Features: AaiRm53EhjBJSs2fXyS6DGMjbBVSP0MEaC3D6JuGvwlg3qKsluBP74vOuDcOi20
Message-ID: <CAKAwkKu8wpdvJ2_gUWvNd+1ajU9CpbPpF-UsaGXkk6ciBgDT3w@mail.gmail.com>
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>, 
	kengyu@lexical.tw, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Mario,

> Matthew,
>
> Can you please try with this diff that applies my idea?
>
> Thanks,
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1f6fd7c372932..5955a273c9ba7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3196,6 +3196,7 @@ void pci_pm_init(struct pci_dev *dev)
>          }
>
>   poweron:
> +       pci_clear_master(dev);
>          pci_pm_power_up_and_verify_state(dev);
>          pm_runtime_forbid(&dev->dev);

I applied this ontop of current head 7dff99b from 7.0-rc1.

c5.metal on AWS did not come back from a clean reboot. Looking at the serial
console shows the exact same behaviour as attempting a kexec. It gets stuck
trying to locate the rootfs, because the NVMe drive has no bus master bit set.

That is also maybe not a viable path to take.

I'm currently working on some instrumentation, will try get my results,
including a full dmesg capture, soon.

Thanks,
Matthew
