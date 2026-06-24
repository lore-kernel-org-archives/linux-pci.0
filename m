Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06E3845D3
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281397; cv=none; b=drAMYhiQDyYOo+UauxnQ9JHjrszx7vHXzOzGjkEGPpLVit8PXKgF8lsONMUhyBmA3CxsBTSiYm4Dm4fRHgw5we9rtm3VJ1XDkZmQA0tCxbN07WVVHjE5iq6qleDrPrg6NgPhO5pQWpy5BGqTPHVGTTuYNnXPg8v+CJtql0mOyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281397; c=relaxed/simple;
	bh=09UhpBZ+vijrWnGbbLkonJ4IjI6EyY7JgTlIvZiLgKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7pO1aFv6mlbNJyDM/3bMBKnDpLseh4vtCoqmyAkbaUcv7pfe20ZSXZc38cqMvTTLodkeq4VvIB17ub4gGgd+XOrkGhDVDCu+FXsmnELwa2YRv0Omgmf9qB/259aJYaKYSf2BK2jCSFK4srJ3VNAVamltXeIqQhzTrEHKTrQIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U0x9O8g/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HBGB/giU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QgQcIioa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AZ78oeSj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U0x9O8g/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HBGB/giU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QgQcIioa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AZ78oeSj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A5FF6D878;
	Wed, 24 Jun 2026 06:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782281393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b8CPZe6k3flAEwqBYslYxYI5mGXrBNfvUtzO/XqGxgU=;
	b=U0x9O8g/qbJsFd6WCvQNQMSD0nJdYHWIhbEkn8fLDeoHYV5+WMcb6pIbv6id8SUXonPbbK
	CUsxtrfU/y0OMtLbAi9R4m21jneaQw+xyWtrxEsv+XqJJdq0rt9BNfgONGzFfSyr3ZHjyg
	+5EKoRbP32MfSTxO/Wj36Aj3baiS7ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782281393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b8CPZe6k3flAEwqBYslYxYI5mGXrBNfvUtzO/XqGxgU=;
	b=HBGB/giUKAng0JIAIjLYLZoHGv3KylFt0I2q/6pLvyjAoKIzpiYwzizQn/Sf5JOV9jOKJh
	McW0oOWGVuO1z+Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QgQcIioa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AZ78oeSj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782281391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b8CPZe6k3flAEwqBYslYxYI5mGXrBNfvUtzO/XqGxgU=;
	b=QgQcIioaQAOKMZ3sKKnk2PXACvuvFtqLTR0JO3EJxuwuE+SBhGCGwXkmpjTbNikIPttJ7b
	Z8wSOWAADi1fphqNvKmfAAYoPoz1lCtvV+vR0fR4DEVlep2HsdM0GiWmYApMBAQ+furQzH
	0/RHzsXjrNgiBRBnQ5ZHaYvE1PeRicI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782281391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b8CPZe6k3flAEwqBYslYxYI5mGXrBNfvUtzO/XqGxgU=;
	b=AZ78oeSj+MLuUW5foCM2JSAjIk3NHPxTQd+iQ4RPDx0L6SyGx/Xak5tsK/rRiKzDFWctQ5
	veEiPIUXLtXptbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C8B2779A8;
	Wed, 24 Jun 2026 06:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UrrmAa90O2quSAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 24 Jun 2026 06:09:51 +0000
Message-ID: <5947c675-efef-4095-8617-3ac30344078e@suse.de>
Date: Wed, 24 Jun 2026 08:09:50 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Aaron Ma <aaron.ma@canonical.com>
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
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
In-Reply-To: <20260623141505.1816786-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,suse.com:url,amd.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,canonical.com:email];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4A5FF6D878
X-Spam-Score: -4.51

FYI a related change to Xorg is at 
https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/2242

Am 23.06.26 um 16:15 schrieb Mario Limonciello:
> Some multi GPU systems may have a VGA compatible device, but that might
> not be used for display.  If due to enumeration order this device is
> found before the one actually used for display then multiple devices
> may show the boot_display attribute, confusing userspace.
>
> When screen info is valid, use it exclusively to find the primary
> device so that only the device backing the framebuffer is reported.
> Only when no framebuffer has been set up does it make sense to fall
> back to the default VGA device.  This ensures at most one primary
> graphics device, preferably the one with the framebuffer.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
> Reported-by: Aaron Ma <aaron.ma@canonical.com>
> Closes: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@canonical.com/#t
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>    * Fix subject
>    * Keep vga_default_device() as fallback instead of remove all
>      together
>   arch/x86/video/video-common.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
> index 152789f00fcda..8ed82fff7638e 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -43,21 +43,26 @@ bool video_is_primary_device(struct device *dev)
>   	if (!pci_is_display(pdev))
>   		return false;
>   
> -	if (pdev == vga_default_device())
> -		return true;
> -
>   #ifdef CONFIG_SCREEN_INFO
>   	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
> -	for (i = 0; i < numres; ++i) {
> -		if (!(res[i].flags & IORESOURCE_MEM))
> -			continue;
> +	if (numres > 0) {
> +		for (i = 0; i < numres; ++i) {
> +			if (!(res[i].flags & IORESOURCE_MEM))
> +				continue;
> +
> +			if (pci_find_resource(pdev, &res[i]))
> +				return true;
> +		}
>   
> -		if (pci_find_resource(pdev, &res[i]))
> -			return true;
> +		return false;
>   	}
>   #endif
>   
> -	return false;
> +	/*
> +	 * No framebuffer was set up by the firmware/bootloader, so fall back
> +	 * to the default VGA device.
> +	 */
> +	return pdev == vga_default_device();
>   }
>   EXPORT_SYMBOL(video_is_primary_device);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


