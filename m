Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566A347C7
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781444330; cv=none; b=mOD9Cby3NjwhcxfHYCtcPwSNkxz8RoikwoWdoGOmKBzGYUDCTLj8OoxEpO/PuMZ/sPFdi++myKxqsJaSFXjmm430VOCxiGUtvvN3v14Dg4wbe2/8tJI4P5ndJsVzV8Y4GgKxkMXAT/A76cM9AqVgZ1EmlzpEo51576zLV8rha2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781444330; c=relaxed/simple;
	bh=imkMf1LWuc5WHnOYfzLBjY+C/lZku32PXLp//Z5mGeY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DT9pfnBKCbKa+HNWLE0Q+tc7m2REzlbhjdvBUl3cZtia931/L+oxoJ1Z2Fv1z/IklO49W28G5BccyWbXDBllPswycjykXngyRuJLIID3h9fQAHnqcS/GSXUyGDVNBFofNOCB11iImt+lNTahB1RwvZSlSyJ5EmT895dZ34lHL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FzkhWlvA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FzkhWlvA"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177b9a02bdso33366731cf.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781444328; x=1782049128; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXg+GT95yYO4T14XPgWTJKtcxJfATzJGx0/pfKwDeqA=;
        b=FzkhWlvAinGRVWzFvkq0b8rhoeql2geAfWJe87dnHiKgbbwsvaO0UO1d+UjOUUK7zJ
         bdznGBvnaT4k2ll8qSO+OlEcX5/ManmerWMwrLbWyX+oT12ApQPM+c/VfOA6ZJLGkMCq
         cFcCMainMSBOPzY8IIqJ/bwYYBXNrjqPJdLUvhlnXYYvPyh/hhCBur6veftbCfKx8FbV
         m7B6sBi2gbTp65Ufw7yFiZQyWo0qd0rhr5AgR79MQphRQNfVv2Lt2QeNdJJMxphTk1oE
         WwBF7nAO3kelpIhqXaqZxeWQqQzQmuJbOeY2lKnwrudqgd9tvrFV9PSdmy+/JJAzImbh
         2nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781444328; x=1782049128;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXg+GT95yYO4T14XPgWTJKtcxJfATzJGx0/pfKwDeqA=;
        b=eY32sTEbs5S+fwK4C+uaKm5bNdhjADMVlR+jA+TwgVsO0PGcXQhVzWwXpe8AbC4t3r
         WZjk7YvgxdQq7HOZK1F3R7CPc0XWlWKz612tw7HriykhPjuY+2N9cjXrSGa/mvFopIiC
         vg+hWfVmjKZ20rEWA6Bzme3KNI+NrxBxB6YVIBfvnJeUnm5DMRcyE8Ln/gQt2IhHQrCy
         anwLx5yeBhZiv2dPujzX0ERD30Grw5p7MOmr0fxo6Uaxibjd76bwiBfNOJfbaq5bafms
         NFeGfsRlMz6dd3WKQ2NmqwFmVJUqllwbNQ2F7f9oUJFuQXrYIv4HuMMx2CksCkCuxUG7
         Os4g==
X-Forwarded-Encrypted: i=1; AFNElJ+NvWLk6emXR9JT6HDK7YQyZoVP40b7zQUofWwyHmTpSCV39J4X3lxPDOlX+Fo2DTR+PN9OAa1VEfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxv2LAWLvRKYzPET34L8mlwejRnzFLRH0L1t7NiqxAuurGO3W
	j2gVHgBRHO/SC+IwfCmWWLuHSDGlKQAadpGJCbEOTpjzK6EoGAR4cMZkkcVuJJZavmM=
X-Gm-Gg: Acq92OEx2AGFV9YwlR64d2w0Up5aKUN8nSA2mu93B6sVlGUo7A0P3GIP4hR9ZXjei71
	kPNhvlU9X5ulc7V4S+wq0CS6UIu0Sqg91NVz77iUdS6OaA4XbN6VN29EMJg7AFVMBl/dTEErBS7
	AHkdeN3DjR6JC7w5A1A0nnB/6HxFHyyAtaUeqPYhaaCTmBbvFPYbFGE0T862EDs818GAINJIddf
	2zMnVX/yCLeQJhB56oF9A1yG2acul4MkR7KlBevFfpsn3vYaDDv+szibcK5enwWNG/hq9hqVn/f
	9hsKisPOYDI/qR/KmKXQINgZNjWWXItJPR1vHnHuN1C0Ge+2wox5s1CAhPFz/n0v6u/Jz1DUpzR
	FmbtKoaH+3AI0xaJXzmOZREIiIgnplyveGXNJPUGSaUpc/6VkilpnMsR85T0WQCvxpvO6nT9wSV
	r8my5BHNfnDUzoeWPoNaSLwpvnqsSrWTb4oStz1m3WU1M3eL1tQHzBogcxxVa4
X-Received: by 2002:a05:622a:8387:b0:50d:66b6:1564 with SMTP id d75a77b69052e-51953503dcbmr85951991cf.14.1781444327877;
        Sun, 14 Jun 2026 06:38:47 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dad16sm73669631cf.21.2026.06.14.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260522202410.3104264-4-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
Date: Sun, 14 Jun 2026 13:38:40 +0000
Message-Id: <178144432039.1257322.9644414453415904478.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=imkMf1LWuc5WHnOYfzLBjY+C/lZku32PXLp//Z5mGeY=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLq7l1REohFN/W+c/zZvmZsiNBGib+GmmJ98Xn
 Q+7rb16wzOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai6u5QAKCRC7dyhM23N6
 3kxIEADBd+AmGBTMM3+Eeu1O0iFW2mY7VSiDXVMIuYE2Aff07zDsPuFqh4iaxqw5y6yQq1RDRS9
 C+LCuvNoHjr972Bm+MNjX7C07NBMYiDKF/eZq0xHbj1XYcvY3GjqVzl5O2NnP0UkUp3d5XxdB2U
 kRMKTDUBoWa3SJaUak+oxi08sxN+Je36bFKJwqBY9dcpbDzgF/LY2TXsLUIsLhTK7mJJZ1Zua4D
 UllLotthUK/tr3huxjhNXxTtHxzpkCFabCnjYT8xZjmKs/WZmMMSP5laKjVC95NnLsDcZQZJcaY
 fVhlX1FaX9DSWDdZ7SsxAYVJ7Ur3pbt9FjS0jeI2lOhMlBGh/ybDkx4+LAnHvXuwa1taPVB55fP
 eavqiJEVaCFIZWubPMrJDMotiK4Re7Jw1ldxwPS0Qef24xJe0PBaNgnXCwEFfIGun6uZ2ev1uiD
 hsnw6UqUOs1u/utfaWudvAaNnZjzHo0l/k5+sc6C6QYbwAOSME6sT5ASpuABBfnrKTvMiveYmU9
 iSshqRHWh3vmaVHLAuamw7P21HrLeUpe1rAs+hC2gyfZ3ZKwrw4ErSfhqVMgkOBVovFuHcx1P/7
 lQyQjY82doo6RAVRWKXjvFekoAN0iqkrC5llrFeQHZvb2oyr/0eG3Rdd4Ga+VUaHcMzU3/xLWHV
 PULRypTcExsyIYg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 10c9b65aa242..e68ae5c172d4 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
>  
>  config PCI_LIVEUPDATE
>  	bool "PCI Live Update Support"
> -	depends on PCI && LIVEUPDATE
> +	depends on PCI && LIVEUPDATE && 64BIT

Please move this to the first patch, fewer changes between patches, and 
also KHO does not support anything but 64-bit mode.

>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 065d5af822f7..96c43b84532c 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -128,13 +157,49 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> [ ... skip 31 lines ... ]
> +
> +err_xa_destroy:
> +	xa_destroy(&incoming->xa);
> +	kfree(incoming);
> +err_restore_free:
> +	kho_restore_free(ser);

This is the pattern we have been enforcing in other places in LUO. If 
the first retrieval fails, return the same error thereafter.

> @@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>  
> +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> +{
> +	struct pci_flb_incoming *incoming = NULL;
> +	int ret;

Maybe make the error return static, and avoid another search through compatible 
FLBs if it failed before?

1. Add "saved_err;"; if it is set, return it right away.
2. Change all errors to use goto save_err;, and at the end of the 
function, assign ret to saved_err;

> [ ... skip 15 lines ... ]
> +	 * This could mean that no PCI FLB data was passed by the previous
> +	 * kernel, but it could also mean the previous kernel used a different
> +	 * compatibility string (i.e. a different ABI).
> +	 */
> +	if (ret == -ENOENT) {
> +		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);

I would assume this is very normal, e.g., no devices were preserved but 
memfd+hugetlb was preserved. Maybe use pr_debug_once().

> +		return NULL;
> +	}
> +
> +	/*
> +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> +	 * but it cannot be retrieved.
> +	 */
> +	if (ret) {
> +		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");

No need to print backtrace, please just print a warning:
pr_warn_once("Failed to retrieve incoming FLB data: %pe\n", ERR_PTR(ret));

> [ ... skip 34 lines ... ]
> +	 * through pci_liveupdate_finish(). This can happen if PCI core probes
> +	 * the same device multiple times, e.g. due to hotplug.
> +	 */
> +	if (!dev_ser->refcount) {
> +		pci_liveupdate_flb_put_incoming();
> +		return;

Pleaes use 'goto put_incoming'

> +	}
> +
> +	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
> +	dev->liveupdate.incoming = dev_ser;
> +
> +	/*
> +	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> +	 * that dev->liveupdate.incoming does not get freed while it is in use.
> +	 */

How would that work? If finish is not called FLB stays around until the 
next reboot.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
