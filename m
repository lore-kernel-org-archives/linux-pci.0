Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350104;
	b=FoiJF1RHF/512MzUJP1bAS+BDe3Oz/7L/moIYNrBikBsXMaRLqIBabFpUHKfRI5SSpLC
	 xpqGmyCu2UGUSag01I83nP8t/8bsGemjNwffT1SqUWsAGFmEnGzXuJ/vWgmxgKdy8vRSv
	 2ZqWsWTs+IZbUW8sTkiYaEUNcqL6sUujbqNOmIZSqnDmqsLzU2WqLTUao1ejffn7d2X7M
	 ADCm7qDdSSUvbE6ij4MV4d/1Yz8636u6gtbBoBe+DRRcHz63O4py1G7c93akBKTTpDGE9
	 Vim/iywqLhr4bdQxRMKP1N1cfPkCBTTubfIuq79GTwnRmRb4SY6xAh0zLROeuxRsSHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350104;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=X74vjL11XQ3Te4wrqiaM5qH4BI5a2H/PHF7diUdGWVQ=;
	b=DgDq+9wpqPqcr/uP4ypHHa/zvBXaxC0Ub0zN3XonyZhH2qi3E6cGz9DLIHbK0WAunKJa
	 9l1KgLDERVu/fgVR+a2b6Tgy3HryMH0Lh+P1JG69tT4VaYYrxVqmSnsnJg/RYFjTcL0AQ
	 iqAxo2zHBms1Q3w1Ryrqb2+ifLQjDfI+NXktL8RKC8LRfE6zeO1ter+OjAdMBVyhIcDNP
	 3CqT5+pD0rpUFIV0AkZRTl7oo5oxU0Y6LvfCdTRe7dNUBxQo0UcWZuheJj/mZXxs93xRa
	 LYXtWW5oPMc0Rv3uFnmvcPJtdcwdhs+hE8w2x8uiSki6F2MYwAcdUlU8bmRgdV3mjdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rotSSlWX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oUUdM6IJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IfdshaT9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N6G91PuC;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561A606A31A;
	Fri, 30 Oct 2026 08:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D561A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rotSSlWX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oUUdM6IJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IfdshaT9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N6G91PuC
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0AEB222B4;
	Fri, 30 Oct 2026 08:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793350102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X74vjL11XQ3Te4wrqiaM5qH4BI5a2H/PHF7diUdGWVQ=;
	b=rotSSlWXK0hL7aZIOf0DmFXIJPx2Jqohniz29FeMJWt6JT2qadt/JclWCMFTzDRZepKLjn
	BJDoiVDnyZa4WiuNy6AkgxZG+AhwN0qNXvtfNOoL6gV0WMvOrWfkhLyHebbuAINHNuftXx
	NVU9Rbumo6YXpltMSy+0xfJxiJq7V0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793350102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X74vjL11XQ3Te4wrqiaM5qH4BI5a2H/PHF7diUdGWVQ=;
	b=oUUdM6IJO+dXK7Ftwi2ota7uQR+uthePhTVmZK3ivyOr0nJNSRyWvXQJPUke6AJzKoyqMK
	rqkh7hdRAoCwMUBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793350100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X74vjL11XQ3Te4wrqiaM5qH4BI5a2H/PHF7diUdGWVQ=;
	b=IfdshaT98dt83MyTmNogjG61HaNd1YAOctwvatW20aRfOENdqs1wAdmuAZSA+PITOL1JS9
	I+e+1U0M/EDPC/+0Tzua9KOh0p00BQRjyXThRgzmWnabRohXKW0z0TDls0wXqoWiDso2nF
	9EOjGZpF9QydCEpcFhn6f9++eHs2pgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793350100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X74vjL11XQ3Te4wrqiaM5qH4BI5a2H/PHF7diUdGWVQ=;
	b=N6G91PuCtcM+qOUAtQPVGq0n89vn9CYjhlaUeartRJhc2caCE4uZYudfJXriLjeLZ2CYB+
	jEqKlsVZSUVz3ZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B7C0132C9;
	Fri, 30 Oct 2026 08:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CcebGNRZ5GoCMwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 30 Oct 2026 08:48:20 +0000
Message-ID: <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
Date: Fri, 30 Oct 2026 09:48:19 +0100
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
To: Hengyu Liang <hengyul@cs.unc.edu>, x86@kernel.org
Cc: mario.limonciello@amd.com, aaron.ma@canonical.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20261029162311.3389523-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,unc.edu:email,bootlin.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29

Hi

Am 29.10.26 um 17:23 schrieb Hengyu Liang:
> Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
> without screen info") made video_is_primary_device() rely exclusively
> on screen_info resources whenever any are available.
>
> However, screen_info_resources() also returns legacy I/O and memory
> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
> lookup fails and the default VGA fallback is skipped.

If the BIOS booted in text mode or VGA graphics mode, the rsp device is 
still the primary display device. So the current matching code is not 
necessarily incorrect. (But also not necessarily correct either. :)


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

Further below in that code is a call to pci_find_resource(). [1]  Why 
does it match with vkms?  Vkms is not even on a PCI device.

[1] 
https://elixir.bootlin.com/linux/v7.3/source/arch/x86/video/video-common.c#L53

Best regards
Thomas


>
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


