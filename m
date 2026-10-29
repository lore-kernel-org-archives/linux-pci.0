Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260473;
	b=HCI/VX9zi/KJSYhYasLMM2g2T84/C7x/e7pwFRiNNv2FnzTBJsTz4zk5ad7OlUj8grtJ
	 MlyQpn8H5tD879v/5+EtIaeYDYl4OezeKDyRLq4IlMlDO2HcfV+ewIVn3YWAksAiQu9qP
	 EYjgcvMvoL00L7ogRa5T3ASb3ZEAJik3q88i2XzdurW8hiuL/tyt3kW4PeX8xI0HOpu2Y
	 ovrPg5yxVu7+D9R2g4lRNUR3VLlzA3XRsyQyVjWyF1te63IJSnXlfDn3k7mpI/GnNHBAH
	 4zvBctT8JZzClABMbifdi5j6iLFgYEKRW90fOBTYFMPCqK3Kj+TctU/YgbOeZHrY6uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260473;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=K3XByBiW3+jKyzFXTjaHSqV/fmoFUufh/r9sKM80Yr8=;
	b=DvhB2sDzU4PJ5vRiHoqV0Igy+CqcZd35bJJ59P5MZvMJtO4lG82FgzKmZvBHUWBS/lxB
	 hSAdJRH7O0b3sWKkLl06tW+zWyphDWnRn5m/OAjXqzFuHWhBiM18VMwk/3m57IrEzB/R+
	 34A/EJadiVQ3rs+iz4zGoVJyMicBR7kKRx+snhs3PtKzKEJwf8hQkLDOm/TEH0odpFpx0
	 Sy8SgbdTrxIA+ri1hlfihvMZP2FsOPGUe156cpb5xz0yMtqdliYVLsmNXqU8/8Voy3dy0
	 l1Wx09SzKJvT0MdCSUm0lv+FN0Fcj7aD8kGAqGUaYwSNP8+8ZxzQ8Yebow8PJM/UDRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rwO5DcRV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kv8yJ+Q1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rwO5DcRV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kv8yJ+Q1;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87433606AA18;
	Thu, 29 Oct 2026 07:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87433606AA18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rwO5DcRV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kv8yJ+Q1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rwO5DcRV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kv8yJ+Q1
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 762F0221D4;
	Thu, 29 Oct 2026 07:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793260470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K3XByBiW3+jKyzFXTjaHSqV/fmoFUufh/r9sKM80Yr8=;
	b=rwO5DcRV1clxIt4F//zc/8Dbdx36/wVWGIoOYssBsvpV2XGU2enca2ExG5PxQ5lvGkCpCA
	2pcxSP+G3zwhETRkhRjwpz4BMlsIq1L1A0B9DC4hUX76etuUpnM7pI5A+65+r08KoVnKGG
	mFWKqaY8D92ycw/jD2mLYowkVOuK1JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793260470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K3XByBiW3+jKyzFXTjaHSqV/fmoFUufh/r9sKM80Yr8=;
	b=kv8yJ+Q12LJcwzYIh+d5Ar9j32GFBtSQQdT+WXdPcVmOyrXKMopi82oZDKzeTQI/P1utQZ
	9ypvDVpXozv+XtCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rwO5DcRV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kv8yJ+Q1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793260470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K3XByBiW3+jKyzFXTjaHSqV/fmoFUufh/r9sKM80Yr8=;
	b=rwO5DcRV1clxIt4F//zc/8Dbdx36/wVWGIoOYssBsvpV2XGU2enca2ExG5PxQ5lvGkCpCA
	2pcxSP+G3zwhETRkhRjwpz4BMlsIq1L1A0B9DC4hUX76etuUpnM7pI5A+65+r08KoVnKGG
	mFWKqaY8D92ycw/jD2mLYowkVOuK1JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793260470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K3XByBiW3+jKyzFXTjaHSqV/fmoFUufh/r9sKM80Yr8=;
	b=kv8yJ+Q12LJcwzYIh+d5Ar9j32GFBtSQQdT+WXdPcVmOyrXKMopi82oZDKzeTQI/P1utQZ
	9ypvDVpXozv+XtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2077B13419;
	Thu, 29 Oct 2026 07:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5LGsMLX74mrwIQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 29 Oct 2026 07:54:29 +0000
Message-ID: <43de9446-a682-46cd-a6da-c9f4362dcb9d@suse.de>
Date: Thu, 29 Oct 2026 08:54:29 +0100
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
Subject: Re: [PATCH] PCI/VGA: Fix boot device detection after framebuffer
 relocation
To: Bjorn Helgaas <helgaas@kernel.org>, wuqianhai@loongson.cn
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, javierm@redhat.com,
 dri-devel@lists.freedesktop.org
References: <20261028231514.GA577494@bhelgaas>
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
In-Reply-To: <20261028231514.GA577494@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 762F0221D4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50

Hi

Am 29.10.26 um 00:15 schrieb Bjorn Helgaas:
> On Wed, Oct 28, 2026 at 05:46:34PM +0800, wuqianhai@loongson.cn wrote:
>> From: wuqianhai <wuqianhai@loongson.cn>
>>
>> PCI resource assignment can relocate the firmware framebuffer BAR, which
>> leaves the base address in screen_info stale.  The VGA arbiter then calls
>> screen_info_pci_dev() from vga_is_firmware_default(), which fails to match
>> the framebuffer against any PCI device's BARs.  As a result, the boot VGA
>> device is not recognized and the arbiter may select the wrong default
>> device.
>>
>> Fix this by calling screen_info_apply_fixups() in vga_arb_device_init()
>> before adding the VGA devices.  This relocates lfb_base to the assigned
>> BAR address so that vga_is_firmware_default() matches the boot device
>> again.
>>
>> Tested on a LoongArch platform, with vga_is_firmware_default()
>> additionally enabled for CONFIG_LOONGARCH via local changes.
>>
>> Fixes: 337bf13aa9ddab8ae47f2677ab75cf69ae33437b ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
>> Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
>> ---
>>   drivers/pci/vgaarb.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index 3e58b2c05c85..aca594651f58 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -1527,6 +1527,14 @@ static int __init vga_arb_device_init(void)
>>   	int rc;
>>   	struct pci_dev *pdev;
>>   
>> +	/*
>> +	 * PCI resource assignment may have relocated the firmware
>> +	 * framebuffer BAR. Update screen_info's lfb_base so that
>> +	 * vga_is_firmware_default() can match it against the boot
>> +	 * device's relocated resource.
>> +	 */
>> +	screen_info_apply_fixups();
> I'm really confused about this.  vga_is_firmware_default() relies on
> screen_info_pci_dev(&sysfb_primary_display.screen):
>
>    vga_is_firmware_default
>      screen_info_pci_dev(&sysfb_primary_display.screen)
>        numres = screen_info_resources(&sysfb_primary_display.screen, res, ...)
>        for (i = 0; i < numres; ++i)
>          pdev = __screen_info_pci_dev(&res[i])
>
> screen_info_resources() returns resource structs with PCI bus
> addresses in them.  These are not valid CPU addresses, so that seems
> broken on any system where bus addresses are not the same as CPU
> addresses.

What we get from the firmware for the framebuffer is a memory range.  
  If the underlying PCI memory gets relocated during the boot, we need 
to update the framebuffer data accordingly. This has worked well for the 
last 20 yrs.


>
> screen_info_fixup_lfb() and screen_info_apply_fixups() may fix the
> issue you see, but I think the way this happens is questionable.

>
> screen_info_fixup_lfb() captures the framebuffer PCI bus address in
> screen_info_lfb_res_start.  Then screen_info_apply_fixups() compares
> that PCI bus address with the CPU address in pdev->resource[].  That's
> broken on any system where bus addresses are not the same as CPU
> addresses.  I think it's also broken because screen_info_lfb_res_start
> may not be at the beginning of the BAR.
>
> I think screen_info_fixup_lfb() should only capture the pci_dev, the
> BAR number, and the framebuffer offset into the BAR.  When we need the
> CPU or bus address, we can always compute it from those values.

This is not sufficient, I think. We did this until a while ago and got 
problems with relocated bars. IIRC aarch64 had a number of affected 
systems. See commit 2f29b5c23101 ("video: screen_info: Relocate 
framebuffers behind PCI bridges") for details.

I'm happy to improve that code though, if we can do something better.

Best regards
Thomas

>
>>   	rc = misc_register(&vga_arb_device);
>>   	if (rc < 0)
>>   		pr_err("error %d registering device\n", rc);
>> -- 
>> 2.34.1
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


