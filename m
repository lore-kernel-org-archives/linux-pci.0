Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133978;
	b=3FewKQpMwr2ooLPFxBbAg1lSsHnljGUF7aNgO4jGHYk3+k/UySGvpjfRQ9zreFJLKvrj
	 yUEBP3cJREJ+jjSnKU1j4nEH6JrsEEeCNim6k0S9nOV9yTRPHeTXAsf+bijZsI6yOmN1A
	 vvrzy4iA3Lx+jB0yvz0n08hHWiu/+vxHKVoT/sI1CzgAJ62m/Hbwq+OFlVhE+V+Dz/ho4
	 52dUESOPaI1Mi0tukhwv9Yu74jLhxMHTmN/kMw/WIP9odG5Xu3FLJWivWmfPQYazXRFB0
	 KADoxAzSbecRhUPb3Pf98Y6o2rjf0GPjBay74fBleVi+JS0A1Rpsip8Fm1Iy6HeTKXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
	b=yyfRpWnZr2xkbECEPH3m/bfZWm0G5PeGgq+/ymF9u2HFj7i+JaAey9jjfuIRG0VqVBos
	 UJAhhMcwPoXr/oCm1h/KU2rNjW8aguCFLoYMgtogrfdveEwZ9AlBgFHHLrS9wPbD+kC92
	 sm9y2EKTi5SDTsB2YlRA7dK+deIheuIe7WZlBJfPoPopfaWLbenkJHhrio4sKZGZO7H3X
	 bcE+VjyIdXbVSm9mk+uVrQ95eRrBpuzBXUrarv8gJ4EeB8FYpY7tJgGrVaRPILTRpams7
	 eY7kfOBLloAAnoDAfuslVP96BaKe7VzjItn9Kptw7fuu1MbrxOSxIR4Aje7hO3rh2uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PdhTt60H;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42908606A32C
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 00:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42908606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PdhTt60H
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f00fc215f9so2197115ad.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133977; x=1795738777; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
        b=PdhTt60HfDdlbgtnPHfsSmeHBydQzoPU7kBA2tY0Ozd78IUkx0lFNNH2yQEnk+t921
         4E9Tm4vx1WTnyn6wVtiNLws9au3Om8UjAH+aHWnF9UWUCSm6dRehNZtZrRMRyiJKAdfQ
         YnTwSvF8Sds1TTxbi5V/mZOO0ENi8tkjlt9pqsZCHwuUE36BF1CfNzDd6CjA1gvbCV0K
         t8tBNb4lXwSyQhCSx3AtuTpJROIDOnqKE7PXyQm+EW6Ikp8UHZwMZtLLhZ8OhuurDTSV
         31cPFPu1KFP9meTVUMuhIsGXcN1R94M301aF17ZwKIG89GFOnVfy1AAlTXsPDOoCWZDL
         cbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133977; x=1795738777;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7l+AyO/cRMVQJwJa64VigJKwgCGiEZe5FhWi4AHvFM=;
        b=i4Jk99Oa631ddJDTd5z4lu0QCj58Tfi+53xqzkaPISQWcZHXK8s8SaLmyp5cUONubm
         eSDN7XWaR40zhkmihUWWH573LmvDvMV6KZk+PEU7N/kMUCCl/7tH3VswQZFVITR+2eSl
         XQNBv148CvxnLLluxGSc/eVm+5D1KsRYuUHf+uD+xx1kUHsIqsYlk0w66aq736UfnYNF
         A4UEsSLCqr8kb/LvmbnLyTYbow+GhbKmCdMfoEDZ44B4jScZNYjKBlfj0MrA+yNjvBFb
         FDmY2eIXU35opYN2K6PQuNPPhb1w+knk/PdkT0HkHlN0XzMFJnW5HMavjAAGAjKukGBE
         15vw==
X-Forwarded-Encrypted: i=1; AL+hErEDZZtw+hMy8t4FQipOhqCDHwKtT0QSboVR9UjzQpecZJLr7BIM9DKQMK3FJsbwylnG6aHdEpihnpM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ps6EnPbmxmTlzC+dy+yqh766VpYJNxsl9Vj2/SRBmxLjOTdWj
	IKqkm6HRI4r0i+2yOV+xyGsk2sgO8s1iX8PWHFGep0ncWumIfcuZl8VmuLgzf8vG2A==
X-Gm-Gg: AZFdTZeZdi1+k/t3ZCYOMurZz60/wTbbEI0+YvwBSa87s2yAV6ydhZ5N+naxZJsSkXH
	H4NnXNChWsQn5NEWS0YoW/FHnOfGDOADpDM1+24Uk6yNNClYYXyOXc6//Gym/rBwor35r9B6b9m
	aH3mYyedq1vUaZSy0sxBmfsPS9ObYigfX5Yd3rk2AKJkVBIeEk9rYnm7yyRK3Qxambwt0+Gm4WC
	mglSyewloJp5GTWiKD1bXe8nfuFLeJgt5aNfTlDTtxp8r+J8pB92iM/w7Ijwpb1PmszqNWheMDI
	3AyurrGXwPGEP7b8+ToE9fhFTphoGGSG36v83JgKviJPV06r8Sb0fllEfQJNEeaqrEsStvwf+oq
	UDgOqECytG08kNrgxPACwky1q0hPJseZYIG1grKTCsh8eLMsgtPf85zns62LzqNiM9XqWyGDSdC
	ArmtfTkPPVdElWP6iXDzhhXZuzQPSAYSzyfNN9KkDe57REqVgHnFmV/4ZMN4QZkU7EPqT2jJ6/g
	rWxlsCx1OPSQM1rlWCWodoo9EvSjSfzQiNpIOdNEGP6U3Hvknn89bBiTEORYSWZlAHjKhsYUOLf
	xDMcZOjiyJpGK1G2laCQ9IGqDJVdDXakjk0weq6jCaZByDHbgg8XUw3PsQnMVUwx
X-Received: by 2002:a17:902:e542:b0:2e9:6b5b:3db6 with SMTP id d9443c01a7336-2f03f1a4967mr13941365ad.30.1795133975980;
        Thu, 19 Nov 2026 16:19:35 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0ddf40sm5969655ad.37.2026.11.19.16.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:19:35 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:19:34 -0800
Message-Id: <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-13-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-13-vipinsh@google.com>

On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 12557d45dfee..e6ca4c3fda06 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -11,6 +11,7 @@
>  #include <linux/cdev.h>
>  #include <linux/module.h>
>  #include <linux/vfio.h>
> +#include <linux/pci.h>
> =20
>  struct iommufd_ctx;
>  struct iommu_group;
> @@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct v=
fio_device *vdev) { }
>  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { =
}
>  #endif /* CONFIG_VFIO_DEBUGFS */
> =20
> +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	struct device *d =3D device->dev;
> +
> +	if (dev_is_pci(d))
> +		return pci_liveupdate_is_incoming(to_pci_dev(d));
> +
> +	return false;
> +}
> +#else
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */

No need for the ifdef here and 2 definitions here. If
CONFIG_PCI_LIVEUPDATE is not enabled then the compiler should be able to
optimize vfio_liveupdate_incoming_is_preserved() to false.
