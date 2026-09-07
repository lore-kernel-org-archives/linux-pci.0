Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFEB4052D7;
	Mon,  7 Sep 2026 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764398; cv=none; b=sujn6zb3A5+82W1W/IDqnJvO6Mkq2V3YPEJLJAt7CgRqoH9oX+3uGAllJ7VtLxoSD8cJRtCoOK7PEgmd+2A30450dTZouiemY7ssm5Dot4QPguOZFwjygRrgz9Ks7aP8//Y4LXbaZ9ZEud6fwQX1wlmdf9NJ5bF76hNXzoT3UnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764398; c=relaxed/simple;
	bh=68zq9K51Ay0P16Ip57VHSJhSwyjNPhK8KfIuClbnaR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRKBKetIssu173hxJJHIYEXmSsxgBttAjk9or88HerMK/I69c8/6xwzGlua1/tPflhyDpVMzzQ8TlS7S18mTIlhNCPFbJdseEcM8HFN4SX34APWBeHWF1d8UBXAENJmijqvvzSCUnq2VR0NEEw7NEvFuSVgX6stYfndKThWltC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wlIPwCRp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cx9KJBXU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e0rZrifk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5f9VZldn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wlIPwCRp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cx9KJBXU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e0rZrifk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5f9VZldn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FA391F750;
	Mon,  7 Sep 2026 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788764373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=do8tCb/WEQVB5WcbQ+nX9pTcXqhCTxoFf3t+kQA7Cd8=;
	b=wlIPwCRpbSjG1YwZQLRGeVaoTAbjDlZ5mQUVIr4JXo/iBT3a4Q0iH6q3KuiIBzJUKfxnX9
	/Oxidgg3nxHJKpUzDbw6cBurL8wqFfjnExlFpplf04hO2aRAAa7RStxV7HsL02DYMbRZNr
	3UDtjGBoTvoHszkZaN/z9Q3bUK9ze6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788764373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=do8tCb/WEQVB5WcbQ+nX9pTcXqhCTxoFf3t+kQA7Cd8=;
	b=Cx9KJBXUtp5fhYyVV4hzQS2p48f2jp5NsH1gki5wAXk89bfUrjPfS2krewBdl6mcSHoSJy
	NapMeisj3ThAF8Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788764369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=do8tCb/WEQVB5WcbQ+nX9pTcXqhCTxoFf3t+kQA7Cd8=;
	b=e0rZrifkg5vEXUNAp301FUAS6arueahh02Qtfk9f0nOM+BgnLLgvHz6Sgvz7rpoid5c1qs
	BFjB+Zfp+bwj+/p7iA4LqSH5FFkiqvlLvqZjogfaaPbwca795R1Clm3gRhoh2ncfN5mBo9
	e+bwzWMbc0kej1wlII9bg9vhYMRLVqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788764369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=do8tCb/WEQVB5WcbQ+nX9pTcXqhCTxoFf3t+kQA7Cd8=;
	b=5f9VZldnsThtR5Ool3IzbjkvtPK6c0RIReUaSQm+sGldhPOHl7PvojatmPqO4560OylauL
	+3SEaaWT2ZkZcbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7AE513432;
	Mon,  7 Sep 2026 06:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vHVEN9BgnmpDaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 07 Sep 2026 06:59:28 +0000
Message-ID: <22707a1f-970b-4309-905d-13ac794c51fa@suse.de>
Date: Mon, 7 Sep 2026 08:59:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Kconfig: fix typos in core makefiles and purge
 defective DVB debug (v5)
To: Breno Rodrigues Alves <breno3011alves@gmail.com>,
 torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
 linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260905003005.118245-1-breno3011alves@gmail.com>
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
In-Reply-To: <20260905003005.118245-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid]

Please stop spamming this list with revisions.

Am 05.09.26 um 02:30 schrieb Breno Rodrigues Alves:
> Automated review from Sashiko AI revealed that re-enabling the legacy
> DVB_ULE_DEBUG code via CONFIG_DVB_ULE_DEBUG exposes severe race conditions
> on global state variables, leading to out-of-bounds memory corruption.
> Additionally, the debug block suffers from undeclared identifiers (TS_SZ).
>
> Following the core kernel principle of eliminating dangerous, unmaintained
> code, this patch completely extirpates the defective DVB_ULE_DEBUG block
> from dvb_net.c and purges its corresponding configuration symbol from
> the Kconfig tree.
>
> This version retains the verified MediaTek bugfixes and ghost purges:
>    - Fixes MediaTek interconnect typo mapping mt8196.o to MT8196.
>    - Fixes MediaTek regulator typo mapping mt6316-regulator to MT6316.
>    - Cleans up the dangling comment in drivers/leds/Kconfig.
>    - Purges verified legacy ghost weight.
>
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
> ---
>   drivers/interconnect/mediatek/Makefile | 2 +-
>   drivers/leds/Kconfig                   | 1 -
>   drivers/media/dvb-core/dvb_net.c       | 6 +++---
>   drivers/regulator/Makefile             | 2 +-
>   4 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
> index 6bd656668..64170ab16 100644
> --- a/drivers/interconnect/mediatek/Makefile
> +++ b/drivers/interconnect/mediatek/Makefile
> @@ -3,4 +3,4 @@
>   obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
>   obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
>   obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
> -obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
> +obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index d0d318223..800fbd560 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -873,7 +873,6 @@ config LEDS_UPBOARD
>   	  This driver can also be built as a module. If so the module will be
>   	  called leds-upboard.
>   
> -comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
>   
>   config LEDS_BLINKM
>   	tristate "LED support for the BlinkM I2C RGB LED"
> diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
> index a2159b2bc..3b503695e 100644
> --- a/drivers/media/dvb-core/dvb_net.c
> +++ b/drivers/media/dvb-core/dvb_net.c
> @@ -68,7 +68,7 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
>   
>   #define DVB_NET_MULTICAST_MAX 10
>   
> -#ifdef DVB_ULE_DEBUG
> +#ifdef CONFIG_DVB_ULE_DEBUG
>   /*
>    * The code inside DVB_ULE_DEBUG keeps a history of the
>    * last 100 TS cells processed.
> @@ -320,7 +320,7 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
>   {
>   	/* We are about to process a new TS cell. */
>   
> -#ifdef DVB_ULE_DEBUG
> +#ifdef CONFIG_DVB_ULE_DEBUG
>   	if (ule_where >= &ule_hist[100*TS_SZ])
>   		ule_where = ule_hist;
>   	memcpy(ule_where, h->ts, TS_SZ);
> @@ -659,7 +659,7 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
>   			h->ts_remain > 2 ?
>   				*(unsigned short *)h->from_where : 0);
>   
> -	#ifdef DVB_ULE_DEBUG
> +	#ifdef CONFIG_DVB_ULE_DEBUG
>   		hexdump(iov[0].iov_base, iov[0].iov_len);
>   		hexdump(iov[1].iov_base, iov[1].iov_len);
>   		hexdump(iov[2].iov_base, iov[2].iov_len);
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 5a764cec8..f81d1f31a 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
>   obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
>   obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
>   obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
> -obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
> +obj-$(CONFIG_REGULATOR_MT6316)  += mt6316-regulator.o
>   obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
>   obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
>   obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


