Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3A3D3332
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129398; cv=none; b=sQ9utwLPZJZbW+6K2fLeLs+WW4S8cbuXhxel6gaZwfH7lr+T3mBu/nON35hG/rzRjGaupRglcPSsuUcKyz5o5f+EOKP2lODUuw1RI9arDBmre/V7qN3PeVxhqMAW6M6xqaqMirp2qg3+p5aISfYfz+09MSPScfQkJjqze8HHSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129398; c=relaxed/simple;
	bh=8HPlO9h6syLezPB7tv8QuwjjhDGwxOtjBCDDTl2STnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJ2vMsPcly7hxDYDySF9ZVVS+CscRBS5+cnryyGPH5F75f2LeHDFXD4mJ36UlqsmAu2IFo23QMyiu3U7G1hfgZStX5kl3bMhk90VC+sAbMrebSXYrViluJonzrCketa8SZTTZB4rqcNmtZUheeQRzJy4sJJpAh2TTYje1+JnHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XyenKcge; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XyenKcge"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so5493785e9.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775129386; x=1775734186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tT7D8o4V9+zDHS/oQifH2ZnOFQaAuku/SG4Se+wsZAk=;
        b=XyenKcge2tAq7YuyN1wuPG23vN+4Jv23MRzxi1T6e4WY9DvfuDwffZZS4T42+yabS/
         KKh1RR3GczW6qMGa/iuc94u2etxHKxgGxNihio+pSQ34fD/hnD5KXO8eySPrX70kW7NW
         EwHpLl68vuN/A8e+E3J3rXsqx1kVVf1+D8PMP2jlXkJdgYbDYo9bNeuSUQ8KabKa63CT
         pa0lDV4bkg3DQFgOjSSTEtq4RDSJtW8JsYApryx3UtI9/bwmPoHnrpb/BPwzhG7ANVEe
         bCIhwOMh+8imLvSYBWdF0II9bVp7QOiSFQvwnjSkxzcVvWoM5rw6yDF21ytm7Jvm9QRu
         woOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129386; x=1775734186;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT7D8o4V9+zDHS/oQifH2ZnOFQaAuku/SG4Se+wsZAk=;
        b=mimM8+aUCRaG9R1RoUSG+XImfUOpI7dlSVwlrIFDEdT0hn9YvxlOfn2X1oxAbs2Syz
         3YNVSMbr1FDakhzZibTxzEkWpnFdCFhESI/9fcme8ldu94S+IXjd7iFsLwG0B7uUHzIx
         eg+BvpESnQ4xE9RSf3Rf4gczCoiTccAOE7P0h2wx+U2654zXnmAAlYKNdGaC9BvL1cJ3
         MW0eDAmlHIe8Nvh4S2GLI/LVjmOIZ7vmonukphIc5Ho0SGiXMsv4Bq7TXLP3XnTWaXUD
         uLiwO8sntJaYCcNnDmeSDbbSW163pV0lqDlYl8aSxts6v7xxGWv5iWF6aA6Quz0W4MVL
         ipqg==
X-Forwarded-Encrypted: i=1; AJvYcCXa7N96fsYYu8Sp6iv+ec+Luh5BNqGV/uC1ZfHcvRcsjXBaMZ8ypfFwUS1MbC+vxfJ2FagSYHItuMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+1jh3FjGgHgT7P6/LHHJOddILrCkUJRaaE6iETN9Ikmu36Wn
	VGkY1DZCtQqkYNyvKnY6K2lgT+dGP6pkzfmFJ5Of8/lpZWU5lIq2cmSOlrbwg1NgBfY=
X-Gm-Gg: ATEYQzy/KfTNks4GyJ9hoJw+lBU+ZCnmtudjbEsZyH4MpDbjKX81Bjg+oHGW4sHqhyB
	egiOzRDj1RmC54HfhJe1AKpiLSu0vYh/xusSRkawqO344LAbC4RjJz0uZKiZshzrqStMLWSVgpF
	V9AmI/RsOoMBkoWUShAnDwSB8wZchVK3xcPJKk6yPncSOTlW17Wh+hcV0KTlkhqPRpe5EMSJ81f
	x83otPsem4hlXyBR+rUqMtZmogMnNRiJs+O3ydcoqmIAtxVfi0gPTC7UcPXCVNeBx3JFsQJN/Qh
	2i7vIbhDbmR0hymlEXwtbUGq9JMKzWKlDI/p5fBa4gEmNBJRhZbuiJFKRpWsK/UVjqmGidaeHE+
	7seYGiudkSdOnjS4wi+tyPokPtgJR5Tiyg8PlBnYo6ue0nhzwqvjck5aPkOBP2bLvEKUhZu0OnK
	owRGiNMMkP2Cx6g5bqzfgwpIRPkQ==
X-Received: by 2002:a05:600c:8483:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-4888e0cf3a0mr32634805e9.14.1775129386217;
        Thu, 02 Apr 2026 04:29:46 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a705ebdsm74104865e9.10.2026.04.02.04.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 04:29:45 -0700 (PDT)
Message-ID: <51f2be5a-47d2-4a06-92bb-368aaed73530@suse.com>
Date: Thu, 2 Apr 2026 14:29:44 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/31] coco/tdx-host: Implement SPDM session setup
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com,
 yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org,
 xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-28-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260327160132.2946114-28-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.03.26 г. 18:01 ч., Xu Yilun wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Implementation for a most straightforward SPDM session setup, using all
> default session options. Retrieve device info data from TDX Module which
> contains the SPDM negotiation results.
> 
> TDH.SPDM.CONNECT/DISCONNECT are TDX Module Extension introduced
> SEAMCALLs which can run for longer periods and interruptible. But there
> is resource constraints that limit how many SEAMCALLs of this kind can
> run simultaneously. The current situation is One SEAMCALL at a time.
> Otherwise TDX_OPERAND_BUSY is returned. To avoid "broken indefinite"
> retry, a tdx_ext_lock is used to guard these SEAMCALLs.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   arch/x86/include/asm/shared/tdx_errno.h |   2 +
>   drivers/virt/coco/tdx-host/tdx-host.c   | 301 +++++++++++++++++++++++-
>   2 files changed, 299 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/shared/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
> index 8bf6765cf082..7db04fe30378 100644
> --- a/arch/x86/include/asm/shared/tdx_errno.h
> +++ b/arch/x86/include/asm/shared/tdx_errno.h
> @@ -29,6 +29,8 @@
>   #define TDX_EPT_WALK_FAILED			0xC0000B0000000000ULL
>   #define TDX_EPT_ENTRY_STATE_INCORRECT		0xC0000B0D00000000ULL
>   #define TDX_METADATA_FIELD_NOT_READABLE		0xC0000C0200000000ULL
> +#define TDX_SPDM_SESSION_KEY_REQUIRE_REFRESH	0xC0000F4500000000ULL
> +#define TDX_SPDM_REQUEST			0xC0000F5700000000ULL
>   
>   /*
>    * SW-defined error codes.
> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index 06f3d194e0a8..4d127b7c2591 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> @@ -14,6 +14,7 @@
>   #include <linux/pci-doe.h>
>   #include <linux/pci-tsm.h>
>   #include <linux/tsm.h>
> +#include <linux/vmalloc.h>
>   
>   #include <asm/cpu_device_id.h>
>   #include <asm/tdx.h>
> @@ -32,8 +33,43 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
>    */
>   static const struct tdx_sys_info *tdx_sysinfo;
>   
> +#define TDISP_FUNC_ID		GENMASK(15, 0)
> +#define TDISP_FUNC_ID_SEGMENT		GENMASK(23, 16)
> +#define TDISP_FUNC_ID_SEG_VALID		BIT(24)
> +
> +static inline u32 tdisp_func_id(struct pci_dev *pdev)
> +{
> +	u32 func_id;
> +
> +	func_id = FIELD_PREP(TDISP_FUNC_ID_SEGMENT, pci_domain_nr(pdev->bus));
> +	if (func_id)
> +		func_id |= TDISP_FUNC_ID_SEG_VALID;

This check implies pci_domain_nr returning 0 is considered invalid. 
Other callers in the kernel seem to not care, they just use the domain 
nr, so is this check spurious or intentional ?

> +	func_id |= FIELD_PREP(TDISP_FUNC_ID,
> +			      PCI_DEVID(pdev->bus->number, pdev->devfn));
> +
> +	return func_id;
> +}
> +
> +struct spdm_config_info_t {
> +	u32 vmm_spdm_cap;
> +#define SPDM_CAP_HBEAT          BIT(13)
> +#define SPDM_CAP_KEY_UPD        BIT(14)

nit: move those defines above the struct definition, they just break the 
reading flow as it is.

> +	u8 spdm_session_policy;
> +	u8 certificate_slot_mask;
> +	u8 raw_bitstream_requested;
> +} __packed;
> +
>   struct tdx_tsm_link {
>   	struct pci_tsm_pf0 pci;
> +	u32 func_id;
> +	struct page *in_msg;
> +	struct page *out_msg;
> +
> +	u64 spdm_id;
> +	struct page *spdm_conf;
> +	struct tdx_page_array *spdm_mt;
> +	unsigned int dev_info_size;
> +	void *dev_info_data;
>   };
>   
>   static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)

<snip>

> +
> +static void *tdx_dup_array_data(struct tdx_page_array *array,
> +				unsigned int data_size)
> +{
> +	unsigned int npages = (data_size + PAGE_SIZE - 1) / PAGE_SIZE;

nit: There's DIV_ROUND_UP

> +	void *data, *dup_data;
> +
> +	if (npages > array->nr_pages)
> +		return NULL;
> +
> +	data = vm_map_ram(array->pages, npages, -1);
> +	if (!data)
> +		return NULL;
> +
> +	dup_data = kmemdup(data, data_size, GFP_KERNEL);
> +	vm_unmap_ram(data, npages);
> +
> +	return dup_data;
> +}
> +

<snip>

> +
> +DEFINE_FREE(tdx_spdm_session_teardown, struct tdx_tsm_link *,
> +	    if (!IS_ERR_OR_NULL(_T)) tdx_spdm_session_teardown(_T))
> +
>   static int tdx_tsm_link_connect(struct pci_dev *pdev)
>   {
> -	return -ENXIO;
> +	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
> +
> +	struct tdx_tsm_link *tlink_spdm __free(tdx_spdm_session_teardown) =
> +		tdx_spdm_session_setup(tlink);

Is the free() really needed here, either the session is correctly setup 
and tlink_spdm is returned. But if session_setup() files then what about 
calling spdm_session_disconnect() on an unestablished session?


> +	if (IS_ERR(tlink_spdm)) {
> +		pci_err(pdev, "fail to setup spdm session\n");
> +		return PTR_ERR(tlink_spdm);
> +	}
> +
> +	retain_and_null_ptr(tlink_spdm);
> +
> +	return 0;
>   }
>   

<snip>

