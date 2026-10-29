Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261430;
	b=weJMrBaoYTXObJr7H7twDk3B72NSGcHfjaF/vXbya//jc8NnU4rRFPH3wmEkD0W8i5W8
	 WPaEujA4DMmCBPYg5XMgKWEqM3GKa6R8uiAvwpEddFXPoBWUwmM29O598qkTQpqZ2Hjix
	 Z/i/gkbUEN3Nx5lLg2QCsrCOdn1JMnlzxEp6z/Xl7MYta2OzQViwXcbgszKBgmy2XmeFD
	 EVGDkHwtsEHPuXGmwvdzCZlyMi3g6mdps2u44pJyskxwix1cIcZEW4u0XO0hgkXbt1KJa
	 wOsAPoTVpE/UXlBWquqWjhECl5jjOeL2ApFj1VjZxWc/PaFegd6W2IGWpszXUKuBctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261430;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=5rBZ0kFvUh2i3PD86rsaq90lGhsDruIK+LJgf4TiufE=;
	b=FSPVQ44FcmBZ+x1uOT0s1D0XaznArRw2ojVp5gQMeBuRfQQx2QZIxQLg2BzBzWLZkXP1
	 D7s2yVPRJlzNcmwBZtfatOsG2JXlvXA+dBf3sxocKKZ4oFjEi74CpMhq5S5A0KPYqE/rW
	 KW0NmLHlnX5imFsXhv+wH9PGiYO3pB93PUnd+7TFZ4EY1v5cmTeIhjobNAEfcJZPS0r8G
	 or2NmQBrqXnXERxFc9yLEYkf30KKC1UauIKzJNxjZ1i61qjW08lf27M7fHYSnCJ/jhOkp
	 5PTfTz2l7Ihz22ZcNAY9e+FuugX+NJH1fmdvF3zkQsg1afGLEicODkKlAtgQEcxQ3wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fJqSyjMR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="mT+3/vZE";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fJqSyjMR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="mT+3/vZE";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DB606A31F;
	Thu, 29 Oct 2026 08:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E9DB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fJqSyjMR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mT+3/vZE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fJqSyjMR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mT+3/vZE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AB351F385;
	Thu, 29 Oct 2026 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793261428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5rBZ0kFvUh2i3PD86rsaq90lGhsDruIK+LJgf4TiufE=;
	b=fJqSyjMR123MaZQ++4XcOMlHl3DGd8R/7vEzojiPss9ZF4DefVlIxSzLA9+rKt9UfgFTNb
	LL7QBh/a6lsec0KelDwGMENnoJC2fUn3jaPCnJRCLt97g1ghdsT3fZsBM5dV+ek3nQjPSa
	pqGgft5un3mV+q0kVIpPNOwx6S96wMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793261428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5rBZ0kFvUh2i3PD86rsaq90lGhsDruIK+LJgf4TiufE=;
	b=mT+3/vZEIfsBnC6J3GUTIoeq8FKF3UhUq5yQcaqSTDW/qVydR8OWHyyOdIeBbQuQse+1z3
	zweUVYwqht1iZsCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793261428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5rBZ0kFvUh2i3PD86rsaq90lGhsDruIK+LJgf4TiufE=;
	b=fJqSyjMR123MaZQ++4XcOMlHl3DGd8R/7vEzojiPss9ZF4DefVlIxSzLA9+rKt9UfgFTNb
	LL7QBh/a6lsec0KelDwGMENnoJC2fUn3jaPCnJRCLt97g1ghdsT3fZsBM5dV+ek3nQjPSa
	pqGgft5un3mV+q0kVIpPNOwx6S96wMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793261428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5rBZ0kFvUh2i3PD86rsaq90lGhsDruIK+LJgf4TiufE=;
	b=mT+3/vZEIfsBnC6J3GUTIoeq8FKF3UhUq5yQcaqSTDW/qVydR8OWHyyOdIeBbQuQse+1z3
	zweUVYwqht1iZsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E8F13419;
	Thu, 29 Oct 2026 08:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v4IaHnP/4mpvMgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 29 Oct 2026 08:10:27 +0000
Message-ID: <905d902c-461f-4a0e-9ac2-0ad02fe9cabe@suse.de>
Date: Thu, 29 Oct 2026 09:10:27 +0100
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
Subject: Re: [PATCH v2] PCI/VGA: Enable firmware default device detection on
 LoongArch
To: wuqianhai@loongson.cn, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
References: <20261028094634.766723-1-wuqianhai@loongson.cn>
 <20261029033440.973077-1-wuqianhai@loongson.cn>
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
In-Reply-To: <20261029033440.973077-1-wuqianhai@loongson.cn>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,bootlin.com:url,loongson.cn:email]
X-Spam-Score: -13.29

Hi

Am 29.10.26 um 04:34 schrieb wuqianhai@loongson.cn:
> From: wuqianhai <wuqianhai@loongson.cn>
>
> On LoongArch, PCI resource assignment completes during subsys_initcall
> (acpi_init), before vga_arb_device_init() runs.  By that time the
> firmware framebuffer BAR may already have been relocated, leaving
> screen_info's lfb_base stale.  Enable vga_is_firmware_default() for
> LoongArch and refresh screen_info in vga_arb_device_init() before the
> boot device is matched.
>
> Unlike x86, sysfb_primary_display is only defined when CONFIG_SYSFB is
> enabled on LoongArch, so have VGA_ARB select SYSFB there.
>
> Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
> ---
> Changes in v2:
> - Add VGA_ARB's select of SYSFB for LoongArch to avoid an undefined
>    reference when CONFIG_SCREEN_INFO is not set.
> - Restrict the screen_info_apply_fixups() call to CONFIG_LOONGARCH so
>    x86 and other architectures are unaffected.
> - Enable vga_is_firmware_default() for LoongArch.
> ---
>   drivers/pci/Kconfig  |  1 +
>   drivers/pci/vgaarb.c | 12 +++++++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c7408509ba2..55cc60f5d312 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -256,6 +256,7 @@ config VGA_ARB
>   	default y
>   	depends on !S390
>   	select SCREEN_INFO if X86
> +	select SYSFB if LOONGARCH
>   	help
>   	  Some "legacy" VGA devices implemented on PCI typically have the same
>   	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3e58b2c05c85..1b7e915629f9 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -566,7 +566,7 @@ EXPORT_SYMBOL(vga_put);
>   
>   static bool vga_is_firmware_default(struct pci_dev *pdev)
>   {
> -#if defined CONFIG_X86
> +#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>   	return pdev == screen_info_pci_dev(&sysfb_primary_display.screen);
>   #else
>   	return false;
> @@ -1527,6 +1527,16 @@ static int __init vga_arb_device_init(void)
>   	int rc;
>   	struct pci_dev *pdev;
>   
> +#if defined(CONFIG_LOONGARCH)
> +	/*
> +	 * On LoongArch, PCI resource assignment completes during
> +	 * subsys_initcall (acpi_init), before the VGA arbiter runs.  Refresh
> +	 * screen_info so vga_is_firmware_default() can match the relocated
> +	 * BAR.
> +	 */
> +	screen_info_apply_fixups();
> +#endif

No per-arch defines in generic code.  All the setup should work the same 
on all architectures.  All global screen-info state should be maintained 
by drivers/firmware/sysfb.c. Otherwise the framebuffer setup gets even 
more convoluted than it already is.

My question is why does vga_is_firmware_default() run before 
sysfb_init()? [1] Does acpi_init call into it? [1] 
https://elixir.bootlin.com/linux/v7.3/source/drivers/firmware/sysfb.c#L225


Apart from that, we can decouple screen_info_apply_fixups() from 
sysfb_init().  After relocation happens, the PCI code could call the 
helper directly and let it update the global screen_info.

Best regards
Thomas


> +
>   	rc = misc_register(&vga_arb_device);
>   	if (rc < 0)
>   		pr_err("error %d registering device\n", rc);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


