Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267544;
	b=PEfOF208MO7cwEchqpuySgH5sdqgtlPGkNMT2cN3RxZyYc0nLWoCv6B3nWxuXtwZMPVI
	 XhbUj3xLMdtFu0sWmW5tNppHzndvsxLJfKuPB1XlM/jjH/OhaOmUPnJd9HoT0GXFr21yw
	 u2mcfvwMleymZ7XQIAotTgxTbcZwttvzsy3Z65ZojQil9cZcnpLJVFBkpzSqx8MzZjjQ2
	 bxAsoiR+M6EyS1c2hHHO2XluXf2BhI936ED0hpjB9v7mHOng719A4yUebY6W8VqWkf0wA
	 G6edF0pg3AD+FqJE+Ng/tmgPCU/AJrBhI5GnBmBCpyCB7lBQ2JtinKLSPTLYw+7t95w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267544;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KgfMPxb7rVdtQa59yCe2pt/Wfceuew9w8NNWE5ct7iA=;
	b=j1rGu1pW5fxieEIePwYZfNg0akHOhdZ1shAHm9xeAgMLCUGt50+oj2rB1Vk+sZ6nmb2a
	 Dd1SaJ2GyCTNfS7TmpYcar4Oaj3Paec5cJqhEsASUHR25tQylXv26NkTQloI+00xW+fg5
	 RVBFd2NIJ0eOmiNCaOQGtTQOaI0Faez1jOBEZArwvokSzftl3O2ACSXyLOkg7t5XOD+N0
	 0peUDarMsGyPEPr/tjVbsCh7Kx/4ZDuZNUmi3Qp7+4/SPaui9KN1koDsYZ783d4rCpHMn
	 PLUiOBekze0naAMYrt0CQ14g4Yo4y9AeYhujk2O2oDOGxp1BQ1LMx2EGiHe69bfou7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNxQv6xE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11103606A334;
	Mon,  9 Nov 2026 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNxQv6xE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4661F008A4;
	Mon,  9 Nov 2026 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267543;
	bh=KgfMPxb7rVdtQa59yCe2pt/Wfceuew9w8NNWE5ct7iA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UNxQv6xEtOI/4uAlnX6zyUuMYJkpUVIxmZaIig3x+cMqWMHXg9eer9YhNkDX3T5P0
	 NTGkHVg4gsFIMEIqKVDVtaLQpEsjs7nvPVBbCqKZHRNNJjOm5RoLJ0NEhCeTYiFU9R
	 ijawJX5HAWKZttJua7QmbCDLWNiHMIdIrE9lK1iGaB/jkJGT48nfpjCpnP0YcS6Cg0
	 wt916YI9aMMK+v/Ag+qQeo2E2OUYSp+xEXKBzMpknP3Wlm6BlKcrvWrPNnCbvBYrV3
	 nf9lFVb5OgCpyYbDSxP4eazjWBgW2kJrjZFCvsEBWl1ZzMMu6C+ZQt6FnuSpbMz3BF
	 rdpKy1IuhbBHw==
Date: Mon, 9 Nov 2026 17:39:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: octep: Size the interrupt name buffer for the
 full format range
Message-ID: <20261109233902.GA350331@bhelgaas>
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
In-Reply-To: <20261106012126.3385789-1-xujiahao@cmss.chinamobile.com>

On Fri, Nov 06, 2026 at 09:21:26AM +0800, xujiahao wrote:
> octep_hp_request_irq() formats the interrupt name with "octep_hp_%d"
> into a 16-byte array.  The prefix is 9 bytes and a full-range %d
> argument can add up to 11 more, so the worst case needs 21 bytes
> including the terminator and 0-day reports:
> 
>   drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 7 [-Wformat-truncation=]
>   note: 'snprintf' output between 11 and 20 bytes into a destination of size 16
> 
> The values passed today are OCTEP_HP_INTR_ENA (0) and OCTEP_HP_INTR_DIS (1),
> so no truncation actually happens, but the buffer carries no margin over the
> format's worst case.  Give it the room so the warning stops coming back from
> builds that cannot narrow the argument.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507261457.SXXHOjUk-lkp@intel.com/
> Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>

Applied to pci/hotplug for v7.5, thank you!

> ---
> Changes in v2:
> - Keep the compiler warning text on single lines so it stays greppable in
>   the git log (Bjorn Helgaas)
> - Capitalize the subject to match drivers/pci/hotplug/ style (Bjorn Helgaas)
> - Spell out the enum values passed to the format (Bjorn Helgaas)
> ---
>  drivers/pci/hotplug/octep_hp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
> index a0a7f9ccb..801c080e6 100644
> --- a/drivers/pci/hotplug/octep_hp.c
> +++ b/drivers/pci/hotplug/octep_hp.c
> @@ -52,7 +52,7 @@ struct octep_hp_slot {
>  struct octep_hp_intr_info {
>  	enum octep_hp_intr_type type;
>  	int number;
> -	char name[16];
> +	char name[24];
>  };
>  
>  struct octep_hp_controller {
> -- 
> 2.43.0
> 
> 
> 
