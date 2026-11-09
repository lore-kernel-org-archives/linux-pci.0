Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265535;
	b=uvxupN2rqN0Pw/FtfoJAm1a4rKT3OR4oPeS2QK5Iup0G98KHhNxGjS8+2bg4CVQI+MKp
	 i/tA5VVrM0S01DFlcsULRVfVefmldz3Mmmpks0kB6JWye3HV6m8ia1cp4VHo45X9tjbGG
	 6l69+O0uQKW6hhf3kp26k5IyIIluH3zMqtwma9sPD0ROYuo/tBjzF1Bn6aAmglT4TUfqt
	 fre1EV/2xKxrh/OBUKptLlvONz2XPjSdPE8raOeDy6AHcWwWG1XUKy7ApVrixoA68o3CO
	 8YnyeXa64aKrgGGOnk/n2lV228bn7/tDmI7ipBeNv+X3gyerh8BxqALzKdhECaCKFPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265535;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sqZz5022BuGXrLZn6kfW85u+7j3yauL8vru0yVC1DQs=;
	b=h8OTMcyXE9O0cfepEyawPckPL8tDSL1q3cIR9FwbEq48mF9yeja6K1DrHEnf6kOCLH0z
	 CWbYlMJ7Ht6UT/n1pYdrCZFTYrqKnySZNmz1dx1Mkzv1M+ZavYZj0VnRX4v3+zGDwkYcq
	 z5dHIoiralOMlpvJp+sRGYig385maHxaoaPd/HiaSPhcqhINDEs6NUI0c4PFuGMvmjUHJ
	 l9wwbevchquJR0F2s8nWK2Kr+rVVGEnWRB5tL0NvN+kXgJtUxPadTbmAjJURG2SvZsib3
	 FICqOZu7lYEKgkB73EQ+qbQKDrHCzHHBob/fa14RcJEyev5sfQhL/C/R1jh40erNDAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBxmVcDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9872606A325;
	Mon,  9 Nov 2026 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBxmVcDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3798E1F008A2;
	Mon,  9 Nov 2026 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265534;
	bh=sqZz5022BuGXrLZn6kfW85u+7j3yauL8vru0yVC1DQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JBxmVcDuLQ7CRPW3g6+CkaVxzKGgPDjpgmViVGunMtwm13kWtTATtUuLVREV6cTxE
	 UlttN50GzLUtxGNEIcDmbi41lYyB4pgudPS72On4s2pVnuW148OzTIDXb5O+hCggJ+
	 fJokS+4iUayNJ4eyBdi+Z9RdgTQOqh8dDa31IBD6K4nNudpZbP/0oBMI4BrqrjXpjh
	 nuiGTffd3KROsVZpuLoBSa81sy0pHB4Zcil0ucYFKVaLTZp2wkoZ+oKXOHZrbOTeX0
	 3+8ZWKFaul+DoKk6XJ/iCQYzYZTTSBX7HDS0CZr46dmd/iEtn1H42IFMfKIRgrwUzo
	 zy0CTAb7aaPpQ==
Date: Mon, 9 Nov 2026 17:05:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Yifan <yifan2.li@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wentao Liang <vulab@iscas.ac.cn>, Li Lili <lili.li@intel.com>,
	Wang Jie <jie.wang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: Keep ptm_enable_cnt balanced when
 pci_enable_ptm() fails
Message-ID: <20261109230533.GA341229@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104121457.2108515-1-yifan2.li@intel.com>

On Wed, Nov 04, 2026 at 08:14:57PM +0800, Li Yifan wrote:
> Since commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically
> for Root and Switch Upstream Ports"), pci_enable_ptm() takes a
> reference on the device and on each port of the upstream path, and
> pci_disable_ptm() releases them. If pci_enable_ptm() fails, the counts
> can become incorrect in two ways:
> 
> 1. pci_disable_ptm() decrements dev->ptm_enable_cnt without a check.
>    Many drivers ignore the return value of pci_enable_ptm() and call
>    pci_disable_ptm() unconditionally, for example mlx5 and bnxt. If
>    pci_enable_ptm() failed, for example because the upstream port does
>    not support PTM, the count becomes -1 and stays negative after the
>    driver unbinds. Then pcie_ptm_enabled() returns true, and
>    pci_resume_ptm() can enable PTM on the device after a resume,
>    although the upstream path does not support PTM. Before
>    e1092d5e15e6, pci_disable_ptm() did nothing if PTM was not enabled.
> 
> 2. If __pci_enable_ptm() fails for the device after the upstream path
>    is enabled, pci_enable_ptm() drops the reference on the device, but
>    it keeps the references on the upstream ports. For example, this
>    occurs if the device has no PTM Capability and its upstream port
>    has one. Callers that check pcie_ptm_enabled() before
>    pci_disable_ptm() never release these references, so the upstream
>    ports keep PTM enabled with no user. Callers that call
>    pci_disable_ptm() unconditionally release them only through the
>    underflow in 1.
> 
> Fix both problems in one change, because a fix for only one of them
> makes the other one worse. Release the upstream references when
> __pci_enable_ptm() fails. Make pci_disable_ptm() do nothing if PTM is
> not enabled for the device, and use atomic_dec_if_positive() so that
> the check and the decrement are one atomic operation.
> 
> The fix for 2 is based on a patch from Wentao Liang [1].
> 
> Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
> Cc: stable@vger.kernel.org
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20261102222817.GA983941@bhelgaas
> Link: https://lore.kernel.org/r/20260616141733.1688264-1-vulab@iscas.ac.cn # [1]
> Signed-off-by: Li Yifan <yifan2.li@intel.com>

Applied to pci/ptm for v7.5, thank you!

> ---
> Wentao's patch [1] fixes only problem 2, and it is not applied. It
> does not build on v7.4-rc1 ("parent" is declared inside the
> "if (!dev->ptm_root)" block), and with only that fix, callers that
> call pci_disable_ptm() unconditionally release the upstream
> references twice. This patch includes his fix with the build fix.
> Wentao, if you agree, please reply with your Signed-off-by, and I will
> add you as Co-developed-by.
> 
> Tested on v7.2.7 with this patch (it applies without change), on a Nova
> Lake-S system with an I226-LM (81:00.0, no driver bound) behind Root
> Port 80:1d.0. A test module calls pci_enable_ptm() and
> pci_disable_ptm() three times and reads ptm_enable_cnt of both devices.
> It makes pci_enable_ptm() fail in two ways: it hides the PTM Capability
> of the Root Port (no upstream PTM), or it clears ptm_requester of the
> I226 (the device fails after the upstream path is enabled). "Guarded"
> means that pci_disable_ptm() is called only if pcie_ptm_enabled().
> 
>                                   without patch        with patch
>   enable succeeds                 dev 1/0, RP 1/0      same
>   no upstream PTM, unconditional  dev -1, -2, -3       dev 0
>   no upstream PTM, guarded        dev 0                dev 0
>   device fails, unconditional     dev -1, -2, -3       dev 0, RP 0
>   device fails, guarded           RP 1, 2, 3 (PTM on)  dev 0, RP 0
> 
>  drivers/pci/pcie/ptm.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index bd3bd39f6372..522975c87bd9 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -171,6 +171,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>   */
>  int pci_enable_ptm(struct pci_dev *dev)
>  {
> +	struct pci_dev *parent = NULL;
>  	int rc;
>  	char clock_desc[8];
>  
> @@ -183,8 +184,6 @@ int pci_enable_ptm(struct pci_dev *dev)
>  	 * we can enable PTM.
>  	 */
>  	if (!dev->ptm_root) {
> -		struct pci_dev *parent;
> -
>  		parent = pci_upstream_ptm(dev);
>  		if (!parent)
>  			return -EINVAL;
> @@ -201,6 +200,9 @@ int pci_enable_ptm(struct pci_dev *dev)
>  	rc = __pci_enable_ptm(dev);
>  	if (rc) {
>  		atomic_dec(&dev->ptm_enable_cnt);
> +		/* Release the references taken on the upstream path above */
> +		if (parent)
> +			pci_disable_ptm(parent);
>  		return rc;
>  	}
>  
> @@ -240,13 +242,18 @@ static void __pci_disable_ptm(struct pci_dev *dev)
>   * pci_disable_ptm() - Disable Precision Time Measurement
>   * @dev: PCI device
>   *
> - * Disable Precision Time Measurement for @dev.
> + * Disable Precision Time Measurement for @dev.  Do nothing if PTM is not
> + * enabled for @dev, for example because pci_enable_ptm() failed.
>   */
>  void pci_disable_ptm(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent;
> +	int cnt;
>  
> -	if (atomic_dec_and_test(&dev->ptm_enable_cnt))
> +	cnt = atomic_dec_if_positive(&dev->ptm_enable_cnt);
> +	if (cnt < 0)
> +		return;
> +	if (cnt == 0)
>  		__pci_disable_ptm(dev);
>  
>  	parent = pci_upstream_ptm(dev);
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.43.0
> 
