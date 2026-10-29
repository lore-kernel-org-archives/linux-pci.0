Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303537;
	b=4evYRCO16bs9VWBCFz/pWeVqtPtSOwADVWD9qsksMhcyqim0Wqu4pRFDeIhZ+Vj8qRkL
	 /eWV8CDrp+jj1oROnJSSJaYXBwL9bSkZF7cLNFZG0Uf5QYCJ69pJOVOkQtmhNBB4EshHJ
	 CjpEZHu7I8v/bjYFt5g86zN9fRe8BTZG5WyE9fXv4BmmhsmF1Xa3rr5/GkVGNdkxGDIfT
	 GVfSPevApnLxFUf6FK53Msdhxyqjn7M/qnc56aXK7ndchRlAZU4ZY39gzbFl5T9wjqtma
	 p3d9jXAwj2o/LSI8SN7F1FKQXR94nEg2WPh0buw4/KIWyaXvSlBYONkC9k92IftAd2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303537;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0qbJjRietxHEVFz3F+hunDpmsoICZE/W8xHIere+GDw=;
	b=cC8mkrZ34tNZIZLXDm2JZo4NP89V7SvVewNbzVG26SxwCVghPbt/zFW9/wZ4xjXcZ+Ad
	 5pNMzMhE+5aR9f1nu00FFlRhlZCYjc5fiTRQ0AnX265i4r3GH6imwgb8z7V/Fwuy3Gcv3
	 1LP+mdUTm/299/wnGTFag7tn0moj3EtPoOqwzbwxn2CCNbyoHRryoe4FN2wS1VHW/GwJC
	 9NqqaxFm/3xVAerLoDjQ7nr0PEhN02VP4QwqhuiVkAtO/jVvr93yb7xDvjyG/RATt054w
	 csPOiMaADeCya8WWcOsw+5cvfEVrjmrU1WKu1WRAJ7B2E/TXTtsJXtJN8x5Erw1nJtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h52fsTYz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06464606A31A;
	Thu, 29 Oct 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h52fsTYz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A31F01816;
	Thu, 29 Oct 2026 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793303536;
	bh=0qbJjRietxHEVFz3F+hunDpmsoICZE/W8xHIere+GDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h52fsTYz8DHnte5+njB9dfCiduRdFbNvmNHzl3EEQNAu3NfVLVFOpsbrQ5AQqzN59
	 ykAnHU5D+U4h/NRgAmYc+gFyCD9ed8kHVij2fXF8QTBdGe8VRxmQmg9zLcOe71WmvZ
	 UserQK5fC8GqfrAZ1fAg9sBwj0rnqE/5CBBxPEIUjQaGKWF6q75OC88C/Xr2CbTobR
	 oNMIPqba+YzvecABOxP0ad04wVYsRRrq0jFJ7Z4cM5v1o733AXay9R53FUUyVvRX4V
	 eESCZMOcpso6YKcnlBU6kfyV5eXSL5YlbgDhAC7vcxFOL8K6Dl8I77qQQZJi22l+oU
	 62Q7rnbG8rUyg==
Message-ID: <2c8b54e9-e4a9-4394-bec5-308adad5daff@kernel.org>
Date: Thu, 29 Oct 2026 14:52:12 -0500
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy
 modes
Content-Language: en-US
To: Hengyu Liang <hengyul@cs.unc.edu>, x86@kernel.org
Cc: tzimmermann@suse.de, aaron.ma@canonical.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261029162311.3389523-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 11:23, Hengyu Liang wrote:
> Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
> without screen info") made video_is_primary_device() rely exclusively
> on screen_info resources whenever any are available.
> 
> However, screen_info_resources() also returns legacy I/O and memory
> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
> lookup fails and the default VGA fallback is skipped.
> 
> On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA loses its DRM
> boot_display attribute and fbcon leaves the console on VKMS. This can
> be checked with:
> 
>      cat /sys/class/drm/card1/boot_display
>      stty -F /dev/tty1 size
> 
> Without the fix, boot_display is missing and tty1 is 48 rows by 128
> columns. With it, boot_display contains 1 and tty1 is 50 rows by 160
> columns.
> 
> Use resource-based selection only for linear framebuffers. Fall back to
> vga_default_device() for legacy display modes, while keeping EFI and
> VESA framebuffer ownership authoritative.
> 
> Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() without screen info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Tested in QEMU/KVM with identical KASAN configs: SeaBIOS VGA text mode
> (with and without VKMS), VESA, and OVMF with one and two virtual GPUs.
> All 26 guest-only helper checks pass, including EFI/VESA framebuffer
> ownership, missing framebuffer resources, and addresses above 4 GiB.
> Also build-tested x86-32 with/without CONFIG_SCREEN_INFO, and x86-64
> without CONFIG_SCREEN_INFO.
> 
>   arch/x86/video/video-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
> index 8ed82fff7638..b8f83346dfe8 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
>   
>   #ifdef CONFIG_SCREEN_INFO
>   	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
> -	if (numres > 0) {
> +	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
>   		for (i = 0; i < numres; ++i) {
>   			if (!(res[i].flags & IORESOURCE_MEM))
>   				continue;
> 
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

