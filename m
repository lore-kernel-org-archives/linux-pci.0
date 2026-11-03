Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733830;
	b=23wjbtjdjo5PfIG2wtSI6r5KlfsuUq5Wob19O/QzHdBzJD4fanCl2MF5BqF2NH6YBH5/
	 XA6wBoihCASrRTuJrx0v2itfrUmzehCI7HiXTI7BtAlEge6cQAZOuXlHiYe8ILEprx2rW
	 Hm+mAEoglJxWTsyF8fMpxPopAhJVCS2vzY6NvBZ14gGRnkQu39d4up5Ku3+bFD/7QvXl/
	 ndsRlMJ0mf6tAKkYWr2G06eMVJgpL3SVbIyxMDirhn6p2l1VJuV6s7gKqPLTlSPqhi/F6
	 UGoncdslQyVlI3Zz8RfuC3ovkT22t2ssFPHhAi9I6a+2mNsjR+9oCqGRZPvSy8U5lDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bM/PWZRdJ5vBkRuduM2rCijVDP1L8R0XfcxtbD8OeCI=;
	b=Tv7HUuCG7NVsBn2H1YHzbfr07TArhlfZXm8Rsukl9t4mkSyiENTZdDwnR+YwFjH2gtvk
	 6RjjPtIuwt3hPQ5CSmlITNeu7K/HsFSjMCfLbQeQfIYSWuFyDqzfI2jHNCjuDWPtmj5iN
	 A+AigmkO2nCEcTIgea2bTOadDvwC0mMj5iG+A/OpY52HrY3cqUBZUzkUGbMccecPxGgAR
	 +mfbQXhhLcUpngUxf5iTYtMU/HWi7awYqx/+Un+akJeMqRVsktf2ylZO+LAy0bGazL+gX
	 03bq1q9mKpGstILEv8iIOsHg4FL5e/vOT7DNpUH30uQ260MJUOFibJu9zmLmlrFSAIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sz+30YTR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA1606A31B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sz+30YTR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E271F00A18;
	Tue,  3 Nov 2026 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793733830;
	bh=bM/PWZRdJ5vBkRuduM2rCijVDP1L8R0XfcxtbD8OeCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sz+30YTRD2/EsA5GkBkTT8AxO9EUIZeHGagBxfM6UBxTfNMDfgvvH61DybWS2BQGB
	 UllWXK7LbLzbvr7p/MSSsaXvCPt2XbTW8fxa0SDlerHfyxi3NpmeCTAq9BeWYIiRfz
	 hcJiVxBwTbY+DDv+k0id3FwkR/AIOOqvkKRZOxzzu9EbTuWUBBqUk69HxMfQ/4u6ly
	 HdxGdRu+Av5US0kW1TBa/5eYzt0vH6LpgSP0jf28rJIsNTiTZc7fV/hW0h/VMlqNGY
	 CuYJa54b1/eA7H7LiAgZ/Qu879S3P+OJE3uqxiodj9WhW6nVb0ltDYurXDcl+/+Geh
	 pwmzquWC6ENFg==
Message-ID: <sashiko-outbox-195911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for 7.5] pci: Support preferring MMCONFIG for all config
 space accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Triplett" <josh@joshtriplett.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <e1b3a7d153da74d3c50d7c90696b2881f4c0e97d.1793727991.git.josh@joshtriplett.org>
References: <e1b3a7d153da74d3c50d7c90696b2881f4c0e97d.1793727991.git.josh@joshtriplett.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:23:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Even when MMCONFIG is available, PCIe currently defaults to IO-based
> accesses for the first 256 bytes of config space.
>=20
> IO-based accesses are serialized, and can cause substantial scalability
> issues when initializing a large number of devices on a system with many
> CPUs. (Those often coincide, because many systems have PCIe devices per
> CPU.)
>=20
> Add a `pci=3Dprefer_mmconf` option to use MMCONFIG for all config space
> accesses. Also add a Kconfig option (default n) to make that the
> default, allowing a boot-time opt out with `pci=3Dno_prefer_mmconf`.
>=20
> Tested on an AWS c8i.48xlarge system, with 192 CPUs, over five boots
> with and five boots without.
>=20
> Without:
> PCI init 266ms
> Boot to minimal /init 726ms
>=20
> With:
> PCI init 213ms (~20% faster)
> Boot to minimal /init 661ms (~9% faster)
>=20
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e1b3a7d153da74d3c50=
d7c90696b2881f4c0e97d.1793727991.git.josh@joshtriplett.org?part=3D1

