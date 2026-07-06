Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743D3D75A1
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365716; cv=pass; b=E5Fg5o5W7tZXx1fr+ASqKrWEiCObQZ3LYQM+PIiEGxGOzB1W9xIK7VDb3UMeYxoSmw8q1sWmXxxzRyDJ1jPwwxLe8jxKW6YeDnVc6uvUaqeKNbqYm9jtfJDHqayWB32PAqkjdxZQxqyRiUWdEyBdy0704vMIE31Dq/RgGMDpUsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365716; c=relaxed/simple;
	bh=OWqGJ2RXJX8lewCAqOdEDrfTZRegAiM0hVxCTzGD9RM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbJVcm630Kh/JyKbvFD+ez9YTz87r8a3ueIDGTqb+rlq+zQg0wWIl2o9hzwi96lM3Y67nU+P2pK3W3qQsU7va9X1k4bhXWRzj5eFPtZESW0A1xryfjqJ1oKIS+KAA7k13s5OYhuNxMvEHCyaqK2lZiKRJQ9NkOsWPZOW0acidGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDtUgk5g; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDtUgk5g"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845eb7b96feso3273681b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 12:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783365715; cv=none;
        d=google.com; s=arc-20260327;
        b=H03Fls6Vcg8zJ/QdHZi/vrCA2p7qy6xGazmNdm+s3RLztwCOhTCBwEC4uiSiaLCWMH
         ecGRAtc6oAqNTWWLCBnEMNNTtHIETfvykTRCkIEt+UZqSFW3QMmin+8XAXOMcseAhZ/S
         1Vl6d7SOOFkGuK380LIHqxDBJqpdNo3UC2Hzxf2tNL/STp/331B/tMtJkWra0WkYjnlP
         Pwmw2R9JN2CAMkymvrQ8Dalri8+oOBVpe25MnIsBqMaWY88IFNltZ/rsr6TRsfxvhyCI
         NvvRc6V183k5bY9zS2sfBFSS9ZRO8lQAKVLDiRBLMktzGX6/R6UB/UqrRnBZutYHBkua
         JSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3V+CQWicM3KLCiA78W5fLi8JtVISekHIFvC89/oYT3Q=;
        fh=eryslbNqNJ0jlO5SDW24vqGSyGGp2qTDg+ZJhIp2yKc=;
        b=RyVCdUyxXC+654KFDlmYgPmjGsMWW4NcN2zQsjWteoZhujQdMeYDhYw5dnTjiyq7ga
         wIS5Vi1TgRagvoZlCX7VxJarAiUstOJ/2sGk7qXrhxOFxPRMqS44/gyGH+qPVyHSErH5
         FK5rCjMRbI63VdOSHXmjAUetdrWVZmWXYKxtU7ZUwKoCcg6eCc0/cTZE3mZ5boOdKui6
         wsPMNBs6zwhNcvCTbmWkNxnLiBoPWHUs+RXu+npkPC/47nqd/4kyifKaYKmXpyuexvMJ
         w0wHOJuifwMqG4WN5zRDArNjKbMgdQUsqwrO/QcY0fXb6x4zsYNsVC8y3nNkUR8Tu6tj
         iWjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783365715; x=1783970515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3V+CQWicM3KLCiA78W5fLi8JtVISekHIFvC89/oYT3Q=;
        b=cDtUgk5grI4JivQMpngGR+G819QprS220QfFKY28LJilMW34JnPn6e82RXYUP1429S
         6Z+pmhzu+BO1YVay5kodS80Dm8cOieI8vLeE6bYe7nDjX7wHeZNEEKJe3Bz26N+dwif6
         75PJKFPv1KzOKCgB+eP1TyJeBdRanOnEmDD/do1OopRJALv5yChma/0gPcDaaqoUBE87
         vS11S/ukwfIFXUNUORBoP0X0IVqCE8pDFdJBkJHR7NVHVWRNR2yIOBHxnuQOj2DyMiuS
         kM3bkzJK70xC85wSsVeODBUW4P4gL072e/RmhAMLEuZWEdoQyeXV048kKehJlTh9FdP2
         p4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783365715; x=1783970515;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3V+CQWicM3KLCiA78W5fLi8JtVISekHIFvC89/oYT3Q=;
        b=YBqoxpS8yk5qG8JTdP4+ucR4UYOvk1ifr56nm1AH3Io4bFi4/9vmAQq0/xIGXqVn3I
         DMU2rs4LcF/DbwAJYAaoq/xnTgiex/5cjSKh0xOMFx/MLCQuz/gZSKGSfMmFa2vP9RPX
         CJhgmQjR1E4/300oJNLnMW49N/8XA2878RfXeEXLXUpLqnmkbh0lfgsgMBl1DbzeMdSW
         JIR2KBwVrwKy5R7ydw3B3zXQ3crp/pc6WWf58p1I6B8zgbv2TUjxZzeSehQplRC/M0kE
         it3OdjdQHw7TEI6vYFAVTwNalbWLftRNEgCUzbN75ZMdPBHTjxa67GcBoEQjq7ucBke+
         m7lg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1bV5E+T463P+ow98MjEB/qNDTcgpkAjzlxwTPAx0xEQhG9ZiqnyKRIFFhjxXe7KzRIhQ2Ri2YKb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNENApmOoUnDOQtqyl6Mgd9blhlc+p5A/SF7OJ+Iwrvgmnaugv
	S/BghisYCrF4GI6CJHHHYbb+LNt6jDoRASJKmfg5DOh1fz8qlxFLb7EDz5hMoT/bQ9T8ozKkn1A
	icd0anye6Ch2vGqCZ3KWK0vlfj4qowGKi/1+N2uSY
X-Gm-Gg: AfdE7cnWmEfZxMy4+M0E1fILOklWR9v1XO+aBPkyz0ZLcR4WffKqR4ejTBEm09KiKLZ
	1D+ccT3mj9XtgeLalrUrWkPLjBbjWcO/ae9l7gAMx2luBBr5W3MN8BwaYbxTu1TIbl0uu5pbQxW
	3zSE6TJd83Wx6nWeVk7kXoM3KSUethoVKkSNMwTBSpm97z/i4LfufxUckQ7lagjTlhSpfI7Yldp
	pvIwEVQGhdur3aBA6f0Iaq5W64CPhowhT+gzBXQ3Mu7MAmrzPgPDjXSRFsaLFZ8JsZuqP63B0wH
	rEvt12zmmlTnttVgJ5QEsdEEipG80oUisTbZp40ygFx68tPTss8Miybzh1M=
X-Received: by 2002:a05:6a20:d499:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3c08ed14337mr2309434637.3.1783365714229; Mon, 06 Jul 2026
 12:21:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:21:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:21:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-24-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-24-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 12:21:53 -0700
X-Gm-Features: AVVi8Cd9CK0d5hkj-fvDpFPP8e629cstUI2GaeEwDwzmHyMfLj4nBn8EKPgaG0Y
Message-ID: <CAEvNRgGg9YVnLzanueJrHyt9Ra3-q7CmRvP2Sg5dkdctaZpKqw@mail.gmail.com>
Subject: Re: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Setup all trusted IOMMUs on TDX Connect initialization and clear all on
> TDX Connect removal.
>
> Trusted IOMMU setup is the pre-condition for all following TDX Connect
> operations such as SPDM/IDE setup. It is more of a platform
> configuration than a standalone IOMMU configuration, so put the
> implementation in tdx-host driver.
>

I was wondering about hotplug. There's dmar_device_hotplug(). Does it
make sense to do TDH.IOMMU.SETUP from there?

For boot, is the platform-level configuration due to dependencies? Is it
because TDX is set up after IOMMUs and hence TDH.IOMMU.SETUP is done
from the creation of the faux device?

> There is no dedicated way to enumerate which IOMMU devices support
> trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
> devices and tell their trusted capability by the return value.
>
>
> [...snip...]
>
> @@ -119,6 +120,82 @@ static void unregister_link_tsm(void *link)
>  	tsm_unregister(link);
>  }
>
> +static DEFINE_XARRAY(tlink_iommu_xa);
> +
> +static void tdx_iommu_clear(u64 iommu_id, struct tdx_page_array *iommu_mt)
> +{
> +	u64 r;
> +
> +	r = tdh_iommu_clear(iommu_id, iommu_mt);
> +	if (r) {
> +		pr_err("fail to clear tdx iommu 0x%llx\n", r);
> +		goto leak;
> +	}
> +
> +	if (tdx_page_array_ctrl_release(iommu_mt, iommu_mt->nr_pages,
> +					virt_to_phys(iommu_mt->root))) {
> +		pr_err("fail to release iommu_mt pages\n");
> +		goto leak;
> +	}
> +
> +	return;
> +
> +leak:
> +	tdx_page_array_ctrl_leak(iommu_mt);
> +}
> +
> +static int tdx_iommu_enable_one(struct dmar_drhd_unit *drhd)
> +{
> +	unsigned int nr_pages = tdx_sysinfo->connect.iommu_mt_page_count;
> +	u64 r, iommu_id;
> +	int ret;
> +
> +	struct tdx_page_array *iommu_mt __free(tdx_page_array_free) =
> +		tdx_page_array_create_iommu_mt(1, nr_pages);
> +	if (!iommu_mt)
> +		return -ENOMEM;
> +
> +	r = tdh_iommu_setup(drhd->reg_base_addr, iommu_mt, &iommu_id);
> +	/* This drhd doesn't support tdx mode, skip. */
> +	if ((r & TDX_SEAMCALL_STATUS_MASK)  == TDX_OPERAND_INVALID)

Extra space here before ==.

Is there a chance that TDX_OPERAND_INVALID might be returned for some
other reason other than that the drhd doesn't support TDX? I'm concerned
that some drhd would be silently skipped for some other error.

> +		return 0;
> +
> +	if (r) {
> +		pr_err("fail to enable tdx mode for DRHD[0x%llx]\n",
> +		       drhd->reg_base_addr);
> +		return -EFAULT;
> +	}
> +
> +	ret = xa_insert(&tlink_iommu_xa, (unsigned long)iommu_id,
> +			no_free_ptr(iommu_mt), GFP_KERNEL);
> +	if (ret) {
> +		tdx_iommu_clear(iommu_id, iommu_mt);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tdx_iommu_disable_all(void *data)
> +{
> +	struct tdx_page_array *iommu_mt;
> +	unsigned long iommu_id;
> +
> +	xa_for_each(&tlink_iommu_xa, iommu_id, iommu_mt)
> +		tdx_iommu_clear(iommu_id, iommu_mt);
> +}
> +

Is there an equivalent teardown operation? Like on kexec, if TDX is torn
down, would tdx_iommu_disable_all() need to be called to undo
everything, so that after TDX is started again tdx_iommu_enable_all()
would be set up again?

For hot-unplug, would the TDX IOMMU config need to be disabled?

> +static int tdx_iommu_enable_all(void)
> +{
> +	int ret;
> +
> +	ret = do_for_each_drhd_unit(tdx_iommu_enable_one);
> +	if (ret)
> +		tdx_iommu_disable_all(NULL);
> +
> +	return ret;
> +}
> +
>  static int __maybe_unused tdx_connect_init(struct device *dev)
>  {
>  	struct tsm_dev *link;
> @@ -130,6 +207,14 @@ static int __maybe_unused tdx_connect_init(struct device *dev)
>  	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
>  		return 0;
>
> +	ret = tdx_iommu_enable_all();
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Enable tdx iommu failed\n");
> +
> +	ret = devm_add_action_or_reset(dev, tdx_iommu_disable_all, NULL);
> +	if (ret)
> +		return ret;
> +
>  	link = tsm_register(dev, &tdx_tsm_link_ops);
>  	if (IS_ERR(link))
>  		return dev_err_probe(dev, PTR_ERR(link),
> --
> 2.25.1
