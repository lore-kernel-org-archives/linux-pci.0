Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265388;
	b=5eMtX3RUjK7kxApc+r2bU/FrH/lcGAO68hl7OMXj0+z2Zjk63X6FW7xpwALF0tBiDrH1
	 2vVMEBKdILmIB5POzHfIMOCJTFDmfibVbekhMngBF2lVIlgQdIyJgmmeS077PeBUmXBaj
	 8o5K8UzwvpgeAmo4ByojTYyqCAyDOauqEntEf1y1DKgr5+illh+dlxR/a9q2EsR0Kg3KQ
	 UmG8gDATlB+9me3szQPgoToOFugIQLZ5tK3w8n2Wder9qbyyx+NhAxOOXJaTFBrpNAxhp
	 U1Yno2TLAKc+7aoq0KOo+zVyMd57+Z3gWUF2E2c+vjgthDtvA9geKcI5RCuNRJsiTKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265388;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1UKK/To0jM4MQHkafo2SrDtvaNxDgEoLg2sNhgA3Yik=;
	b=Ua0VIUUQ1EIsrW0jGCDQSA92+yo9KAKmY2mEgZbEDVGn8eviAnTKA1Gznwo8kX4oN0CW
	 3/fBKcShjqV/HwmF8Nyug980Ix7SMO7DhBtlu6usrsCxe8eKW6U8DboqP3Q+8TEW8dmeR
	 zWz9dwwjYje/48pMVtSHiRlUbf6vIzG8fZTvR/iLBdLnWxu90hYt8KjVR/0ju/nMMldXT
	 1AbrigdJ01zQPXzijtPyFq1OZRIdTtj/k9XYW3Jks4uaUl8LMxxZ/69uOxIp4WdmYTRC7
	 TWOdPWRz6Qeit3eG/la9UgMnn3lBxgtch2tLFAOqezhB8nzi4Mz8o1fRsM8Y+7tgu8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+6CMvPt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C913606A31C;
	Mon,  9 Nov 2026 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+6CMvPt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF1C1F0089F;
	Mon,  9 Nov 2026 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265387;
	bh=1UKK/To0jM4MQHkafo2SrDtvaNxDgEoLg2sNhgA3Yik=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Q+6CMvPtTEa5ooGZ0LRTuFm7iZpknWqErWir64A1nMY4IYMfb7/uEwJWXvkPIs7sG
	 663kZF7grqmS0QdIIiKqrx8cULyjw53Mfa30yBU863nL8/g1yvjA5gXzTP7v70fr5t
	 C46b5Mu5VPKzC4FczI8dbse+IVZ9nVoKKNhsJuO9URGBo1wgxnL9KTYlh4s6D2XYXT
	 jrobO3ddWxbJPC/IP2sHrcE3gMjivU/wyHN91HFZ/Fzao1y4vJbLDe4xNTRE6SJ9Zh
	 cf1MugsqIniq5H8Zuxx97viV3kvYpoMeLUQKOQMwmm7SkuoEa+2vU4aYdielV3J0cQ
	 dqzuIKOmT21WA==
Date: Mon, 9 Nov 2026 17:03:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Reject negative resource alignment order
Message-ID: <20261109230306.GA339915@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109185515838mOfBTIYMU1_4vygdxd-Gg@zte.com.cn>

On Mon, Nov 09, 2026 at 06:55:15PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> pci_specified_resource_alignment() parses the pci=resource_alignment=
> boot parameter and rejects only orders above 63.  A negative order, such
> as "pci=resource_alignment=-5@...", passes that check and later reaches
> "align = 1ULL << align_order" with a negative shift count, which is
> undefined behavior; on x86 the 64-bit shift count is masked to six bits,
> silently producing a 2^59-byte alignment that mis-aligns (or fails to
> align) the affected IOV resources.
> 
> align_order is a bit order, so parse it with %u.  vsscanf() does not
> accept a sign for %u, so a negative order no longer converts: the
> parameter is reported as invalid and no alignment is applied.  Orders
> above 63 are still rejected and fall back to the page-size alignment.
> 
> Fixes: 6534aac198b5 ("PCI: Bounds-check command-line resource alignment requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Applied to pci/resource for v7.5, thank you!

I included this diff based on Ilpo's comment:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b603d5c5596b..f8968f3be0f5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6511,10 +6511,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 							bool *resize)
 {
 	unsigned int align_order;
-	int count;
 	resource_size_t align = pcibios_default_alignment();
 	const char *p;
-	int ret;
+	int ret, count;
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;

> ---
> This supersedes 1/5 of the v1 series; 2/5-5/5 are unchanged.
> 
> v2:
>   - parse the order with %u instead of %d, as Ilpo Järvinen suggested; a
>     bit order is unsigned, and this also removes the explicit < 0 test
>     added by v1
>   - pr_err() prints the order with %u as well
>   - note the resulting behaviour: vsscanf() does not accept a sign for
>     %u, so a negative order fails to parse instead of being clamped
> v1: https://lore.kernel.org/all/20261107002311316z2o2PFtFGoXh-VbqXtTGg@zte.com.cn/
> 
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the
> pci=resource_alignment= boot parameter and a QEMU e1000 NIC; no extra
> hardware is needed.
> 
> Booting with pci=resource_alignment=-5@pci:8086:100e, the unpatched
> kernel parses -5 and "align = 1ULL << align_order" shifts by -5 (masked
> to 2^59 on x86-64); the e1000 BAR is resized to 2^59 bytes, which cannot
> be assigned, and the e1000 fails to probe.  With this patch "-5" does not
> convert and the parameter is rejected:
> 
>   unpatched                            patched
>   requesting alignment to              PCI: Can't parse resource_alignment
>   0x800000000000000                    parameter: -5@pci:8086:100e
>   e1000 probe failed, no eth0          e1000 eth0 probes
> 
>  drivers/pci/pci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bca3a5d84cd9..e3f701ff9881 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6585,7 +6585,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
>  static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  							bool *resize)
>  {
> -	int align_order, count;
> +	unsigned int align_order;
> +	int count;
>  	resource_size_t align = pcibios_default_alignment();
>  	const char *p;
>  	int ret;
> @@ -6602,11 +6603,11 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  
>  	while (*p) {
>  		count = 0;
> -		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
> +		if (sscanf(p, "%u%n", &align_order, &count) == 1 &&
>  		    p[count] == '@') {
>  			p += count + 1;
>  			if (align_order > 63) {
> -				pr_err("PCI: Invalid requested alignment (order %d)\n",
> +				pr_err("PCI: Invalid requested alignment (order %u)\n",
>  				       align_order);
>  				align_order = PAGE_SHIFT;
>  			}
