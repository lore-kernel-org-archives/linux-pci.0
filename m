Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355318;
	b=QuP0Ni4hx0J0v0E5VBc3/fOop+VxXAKyALb5mdyJZDXrMzCUTc4yioHRwgCbyTgGzRRd
	 1hYR7xossNnfVv6c+D4aAFGdoI/JROKMEC1FdPHWUEcYGGFO/f3Tk7xUuprZv8olY+gry
	 /nry290AvBOGULeF//hwB8LmoQ1/AZ2UvJ2CERhfIlk9rctawJ3BcJZ5CpYlNNiN2aPCB
	 iXrKpR/8NEfjYoNRq7h8fGSs4UmHXve5WPkQN+qi0ol9Qbv67T+YcOJSVjDilvAXIs5KG
	 ZjbQu86wsqzwiODQ3HO/bswLG2dxkmJUUtNr1VhP0uSA54Vy/I1qYjGxVuPPRI+Yv1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355318;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=m22w7RMJNzrxkQqNAZQ41H9A+7pqvWeP1qbkQ9IKDgo=;
	b=bomRAGypnlrufD9fdk6GRnMZ2J9qbPO2NgRVtY2MdrQIhYUPzMCrmpUdqU+C9URJrxle
	 7mr/67Vir8SU9/Ka5msxZyeomXJDZDiGS0nIcJuZJYzcR232+/QZN6cvUd56EZ2amCTO/
	 7xcMnhWgLj4KA7FIYeu1l/wSuDpkpY9X/6f0cu2nA85aHoqvPk0KaCHpfxwJmUHncHWHE
	 Ot6RLRWyTeaXhCNS0sAj/O82MuyBBjpco3VKobM/u9LNGdLryUiBgRec2x8inRFHm4F1y
	 ws9aFJ/ACh1IuAvQWPrByVE1g5a36y315GNxXonTPYxVt3jsUJaivUnRqvYhh5pKUJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UnENQihI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gHxePLCI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UnENQihI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gHxePLCI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A74606A31D;
	Fri, 30 Oct 2026 10:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A74606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UnENQihI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gHxePLCI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UnENQihI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gHxePLCI
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D9932218D;
	Fri, 30 Oct 2026 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793355316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m22w7RMJNzrxkQqNAZQ41H9A+7pqvWeP1qbkQ9IKDgo=;
	b=UnENQihIEk3gfjNuSSmn7YWNhebdmSD6NifB5t3D14NH4buAqHR12TGPk9mfimTD/AY6jk
	ZU+ZvsMHwb/9TF8MjusTxkaGsg6BfSJ57Z56L0qu1OWxw76orGx7d4IN1+keM9xMPIrNur
	rz+U7rH3dSM1T1fmuFXhziWUcFWnops=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793355316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m22w7RMJNzrxkQqNAZQ41H9A+7pqvWeP1qbkQ9IKDgo=;
	b=gHxePLCI26KpHfbvyO0Yr9/0OTmQ0PpBHLhTW82eRW2S46n3L48I/s158DAWersGiZfUlw
	ft/qGnBQZnDAwFCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793355316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m22w7RMJNzrxkQqNAZQ41H9A+7pqvWeP1qbkQ9IKDgo=;
	b=UnENQihIEk3gfjNuSSmn7YWNhebdmSD6NifB5t3D14NH4buAqHR12TGPk9mfimTD/AY6jk
	ZU+ZvsMHwb/9TF8MjusTxkaGsg6BfSJ57Z56L0qu1OWxw76orGx7d4IN1+keM9xMPIrNur
	rz+U7rH3dSM1T1fmuFXhziWUcFWnops=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793355316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m22w7RMJNzrxkQqNAZQ41H9A+7pqvWeP1qbkQ9IKDgo=;
	b=gHxePLCI26KpHfbvyO0Yr9/0OTmQ0PpBHLhTW82eRW2S46n3L48I/s158DAWersGiZfUlw
	ft/qGnBQZnDAwFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3187D13419;
	Fri, 30 Oct 2026 10:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4e56ATRu5Gp4DgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 30 Oct 2026 10:15:16 +0000
Message-ID: <5965d410-e011-442c-b564-e1d5e75154cc@suse.de>
Date: Fri, 30 Oct 2026 11:15:15 +0100
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
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: x86@kernel.org, bp@alien8.de, mario.limonciello@amd.com,
 aaron.ma@canonical.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
 <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
 <20261030092422.300856-1-hengyul@cs.unc.edu>
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
In-Reply-To: <20261030092422.300856-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

Hi

Am 30.10.26 um 10:24 schrieb Hengyu Liang:
> Hi Thomas,
>
> On Fri, Oct 30, 2026 at 09:48:19AM +0100, Thomas Zimmermann wrote:
>> Am 29.10.26 um 17:23 schrieb Hengyu Liang:
>>> However, screen_info_resources() also returns legacy I/O and memory
>>> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
>>> lookup fails and the default VGA fallback is skipped.
>> If the BIOS booted in text mode or VGA graphics mode, the rsp device is
>> still the primary display device. So the current matching code is not
>> necessarily incorrect. (But also not necessarily correct either. :)
> I agree that the device is still the primary display in text mode. The
> patch gets that from the vga_default_device() fallback, since the legacy
> ranges can't be matched against BARs.
>
>>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>>> index 8ed82fff7638..b8f83346dfe8 100644
>>> --- a/arch/x86/video/video-common.c
>>> +++ b/arch/x86/video/video-common.c
>>> @@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
>>>
>>>   #ifdef CONFIG_SCREEN_INFO
>>>   	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>>> -	if (numres > 0) {
>>> +	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
>>>   		for (i = 0; i < numres; ++i) {
>>>   			if (!(res[i].flags & IORESOURCE_MEM))
>>>   				continue;
>> Further below in that code is a call to pci_find_resource(). [1]  Why
>> does it match with vkms?  Vkms is not even on a PCI device.
> It doesn't match vkms. As you say, vkms isn't a PCI device, so
> video_is_primary_device() returns false for it at the dev_is_pci() check.
>
> The problem is on the bochs side. In text mode, screen_info_resources()
> returns the legacy VGA ranges, pci_find_resource() doesn't find them in
> the BARs, and the function returns false there as well. So no device is
> primary, and fbcon stays on the first registered framebuffer. In this
> setup that is vkms (fb0), so the console is never remapped to bochs (fb1).

I see. That makes sense. Thanks for clarifying.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

>
> vkms only makes the console part visible. Without vkms, tty1 has the same
> size with and without the patch, but boot_display is still missing without
> it.
>
> Thanks,
> Hengyu

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


