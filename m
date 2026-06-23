Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01527FD76
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199959; cv=none; b=NMnzHdb6iV1EO5F96i+ZZoBtuTo+XxRgbKthPdYF64FDHpHfs1J33wnb+RB2EEB3cQjN6+wkSNleeahZV2po+ODna9DS7EQsrIj3Igo774Ts1J5fo2Rhp63Yy7p41QglLfphSgo2FB00u2Tb+I/Q7X+ww8T6Xr46xxP4j351Lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199959; c=relaxed/simple;
	bh=M8kVAeqRuW35++nbTGbz0FsQGimP+iiuDhkAoGhc09s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=i5uoV+4847e4hGN3dO76MreCi1oLWQdI0YINcH4BoxLGSzOHUs3UkxiWy+HQk+oWpiY+aA+6GweI2Bzvc+XZf2ggjSkAD5h9AnEkyaNGYuhSV9zHsFSQ9YDkvGQklu/EjfKB13iHaJIpyNN9OoBFMhh9jZz9qmv6DBV2YU+aAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o6HJxsUA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bcRsAgfn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o6HJxsUA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bcRsAgfn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o6HJxsUA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bcRsAgfn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o6HJxsUA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bcRsAgfn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15A246C2BE;
	Tue, 23 Jun 2026 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782199950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o0N4U3ypQ+TNzBl6qmdwYkJxDIWmvvHuUQN3J4Qxyic=;
	b=o6HJxsUApx20YUAn3hqO0YShphGNQYt1Rw5qg8xobnCNwJ/e4Y9YLb4yLrcJ3onbz+E8FC
	eORtI1VhGpWPKJFLFqzGbYpHFw8bk2R1PA4UIZr1LbL4mmlFtTXurGboFASC33yaIMAxSK
	J+jaHlNG2mXQpgFWrVvruHLkS6WrKOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782199950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o0N4U3ypQ+TNzBl6qmdwYkJxDIWmvvHuUQN3J4Qxyic=;
	b=bcRsAgfnCrdM7jS5+psSd8EIvOILXXG+ks1t4RXZbI5jSPZwphtygGJZG4HK4mOY0mUI5u
	UAhDYlhy3l7SpVCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782199950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o0N4U3ypQ+TNzBl6qmdwYkJxDIWmvvHuUQN3J4Qxyic=;
	b=o6HJxsUApx20YUAn3hqO0YShphGNQYt1Rw5qg8xobnCNwJ/e4Y9YLb4yLrcJ3onbz+E8FC
	eORtI1VhGpWPKJFLFqzGbYpHFw8bk2R1PA4UIZr1LbL4mmlFtTXurGboFASC33yaIMAxSK
	J+jaHlNG2mXQpgFWrVvruHLkS6WrKOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782199950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o0N4U3ypQ+TNzBl6qmdwYkJxDIWmvvHuUQN3J4Qxyic=;
	b=bcRsAgfnCrdM7jS5+psSd8EIvOILXXG+ks1t4RXZbI5jSPZwphtygGJZG4HK4mOY0mUI5u
	UAhDYlhy3l7SpVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF08B779A8;
	Tue, 23 Jun 2026 07:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 35MyNY02Omo2FwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 23 Jun 2026 07:32:29 +0000
Message-ID: <3045831e-bbc2-43bd-bc47-3cf720fd8a6c@suse.de>
Date: Tue, 23 Jun 2026 09:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vgaarb: Include 0x0380 devices in boot VGA
 selection
To: Mario Limonciello <mario.limonciello@amd.com>,
 Aaron Ma <aaron.ma@canonical.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622061339.3306046-1-aaron.ma@canonical.com>
 <686c79f1-f4d5-4c76-a57d-fd124c0c1af6@amd.com>
Content-Language: en-US
Cc: dri-devel <dri-devel@lists.freedesktop.org>
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
In-Reply-To: <686c79f1-f4d5-4c76-a57d-fd124c0c1af6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,canonical.com:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -4.30

(cc dri-devel)

Hi Mario et al

Am 22.06.26 um 18:09 schrieb Mario Limonciello:
> +Thomas Zimmermann

Thanks.

>
> Here is the lore link for you for full context.
>
> Aaron's v1: 
> https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@canonical.com/
> My proposal: 
> https://lore.kernel.org/linux-pci/20260621175230.1453114-1-mario.limonciello@amd.com/ 
>

I saw this patch. I was slightly confused, because it says 'fbcon'.

> Aaron's v2: 
> https://lore.kernel.org/linux-pci/20260622061339.3306046-1-aaron.ma@canonical.com/
>
> On 6/21/26 23:13, Aaron Ma wrote:
>> Some firmware boot displays use PCI class 0x0380
>> (PCI_CLASS_DISPLAY_OTHER). vgaarb only registers pci_is_vga()
>> devices, so those devices are skipped by vga_is_firmware_default()
>> and cannot become vga_default_device().

I think the current behavior is correct. The vgaarb is for mediating 
VGA's hard-coded I/O addresses among multiple devices. IMHO the module 
should not manage other graphics devices.

IOW, I think a fix should mostly be outside of vgaarb.c.

>>
>> On hybrid systems this can leave a discrete VGA GPU as
>> vga_default_device() even when the firmware framebuffer is on the
>> 0x0380 device. That makes boot_vga point at the wrong GPU and can
>> make boot_display report multiple devices through different paths.

I assume that boot_display is true for both cards because one device has 
the screen_info settings,  and the other is the 'vga_default_device', Right?

>>
>> Register legacy VGA and 0x0380 display devices for default selection
>> and boot_vga visibility. Keep legacy VGA decode ownership limited to
>> pci_is_vga() devices so 0x0380 devices are not treated as legacy VGA
>> decoders.
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>> Changes in v2:
>> - Keep legacy VGA decodes and owns limited to pci_is_vga() devices.
>> - Keep 0x0380 devices eligible for firmware/default selection and
>>    boot_vga visibility without treating them as legacy VGA decoders.
>> - Update the commit message to describe the boot_vga compatibility goal.
>
> I really think dropping the fallback path (we found nothing, so this 
> VGA thing must be it) is the right direction.
>
> I'd like Thomas' comments about that though.
>
> If we must keep that path, how about instead modify how 
> vga_is_firmware_default() works.  We could instead have 
> vga_has_firmware_default() and vga_is_firmware_default() both.
>
> If the system vga_has_firmware_default() then no longer activate the 
> fallback path.
>
>>
>>   drivers/pci/pci-sysfs.c |  3 ++-
>>   drivers/pci/vgaarb.c    | 27 +++++++++++++++------------
>>   include/linux/pci.h     | 14 ++++++++++++++
>>   3 files changed, 31 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index d37860841260c..843d83ec9550a 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct 
>> kobject *kobj,
>>       struct device *dev = kobj_to_dev(kobj);
>>       struct pci_dev *pdev = to_pci_dev(dev);
>>   -    if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>> +    if (a == &dev_attr_boot_vga.attr &&
>> +        pci_is_vga_or_other_display(pdev))
>>           return a->mode;
>
> I really don't think we want boot_vga exported on a non-VGA device.
> Even if the rest of the PR hangs around, this hunk I think should go.

I agree. Boot_vga does not mean that there's a mode installed, but 
rather that the VGA device got posted by the BIOS/UEFI. That's clearly 
not the case for the other-display device.


>
>>       if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index c360eee11dd9e..56a86779e6d28 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -741,6 +741,7 @@ static bool vga_arbiter_add_pci_device(struct 
>> pci_dev *pdev)
>>       unsigned long flags;
>>       struct pci_bus *bus;
>>       struct pci_dev *bridge;
>> +    bool legacy_vga = pci_is_vga(pdev);

Just a word on terminology. AFAIU in this context 'legacy' does not mean 
that VGA is legacy. Legacy refers to VGA's original hard-coded I/O 
ranges (e.g, 0xa0000, 0x3c2, etc.) .



I think Mario's suggestion at [1] might be a better way forward than 
modifying vgaarb. For boot_vga, we want a VGA device. For the primary 
device, we want the device with the pre-configured framebuffer on it. So 
I'd do something like this in video_is_primary_device():

if (screen_info is_valid) {
     // do the screen_info test from [2]
} else {
     // fall back to the default vga device. [3]
}

This should get us at most one primary graphics device; preferably the 
one with the framebuffer. With no framebuffer set up, using the default 
VGA seems a sensible choice. We can still have distinct boot_display and 
boot_vga flags, because this is what the system looks like.

And with that, another patch has to go into the Xorg server. Support for 
boot_display got added in commit 41c58693c ("Add check for 
`pci_device_linux_sysfs_boot_display()`") [4] AFAICT.  This needs to be 
reworks a bit, so that it first tests for boot_display; and then falls 
back to boot_vga if the former did not exist.

[1] 
https://lore.kernel.org/linux-pci/20260621175230.1453114-1-mario.limonciello@amd.com/ 

[2] 
https://elixir.bootlin.com/linux/v7.1.1/source/arch/x86/video/video-common.c#L49
[3] 
https://elixir.bootlin.com/linux/v7.1.1/source/arch/x86/video/video-common.c#L46
[4] https://gitlab.freedesktop.org/xorg/xserver/-/commit/41c58693c

Best regards
Thomas

>>       u16 cmd;
>>         /* Allocate structure */
>> @@ -762,21 +763,23 @@ static bool vga_arbiter_add_pci_device(struct 
>> pci_dev *pdev)
>>       }
>>       vgadev->pdev = pdev;
>>   -    /* By default, assume we decode everything */
>> -    vgadev->decodes = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
>> -              VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>> +    /* By default, assume VGA devices decode everything */
>> +    vgadev->decodes = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>> +    if (legacy_vga)
>> +        vgadev->decodes |= VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
>>   -    /* By default, mark it as decoding */
>> -    vga_decode_count++;
>> +    /* By default, mark legacy VGA devices as decoding */
>> +    if (vgadev->decodes & VGA_RSRC_LEGACY_MASK)
>> +        vga_decode_count++;
>>         /*
>>        * Mark that we "own" resources based on our enables, we will
>>        * clear that below if the bridge isn't forwarding.
>>        */
>>       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>> -    if (cmd & PCI_COMMAND_IO)
>> +    if (legacy_vga && (cmd & PCI_COMMAND_IO))
>>           vgadev->owns |= VGA_RSRC_LEGACY_IO;
>> -    if (cmd & PCI_COMMAND_MEMORY)
>> +    if (legacy_vga && (cmd & PCI_COMMAND_MEMORY))
>>           vgadev->owns |= VGA_RSRC_LEGACY_MEM;
>>         /* Check if VGA cycles can get down to us */
>> @@ -796,7 +799,7 @@ static bool vga_arbiter_add_pci_device(struct 
>> pci_dev *pdev)
>>       }
>>         if (vga_is_boot_device(vgadev)) {
>> -        vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
>> +        vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
>>                   vga_default_device() ?
>>                   " (overriding previous)" : "");
>>           vga_set_default_device(pdev);
>> @@ -1483,8 +1486,8 @@ static int pci_notify(struct notifier_block 
>> *nb, unsigned long action,
>>         vgaarb_dbg(dev, "%s\n", __func__);
>>   -    /* Only deal with VGA class devices */
>> -    if (!pci_is_vga(pdev))
>> +    /* Only deal with legacy VGA and other display controller 
>> devices */
>> +    if (!pci_is_vga_or_other_display(pdev))
>>           return 0;
>>         /*
>> @@ -1530,12 +1533,12 @@ static int __init vga_arb_device_init(void)
>>         bus_register_notifier(&pci_bus_type, &pci_notifier);
>>   -    /* Add all VGA class PCI devices by default */
>> +    /* Add legacy VGA and other display controller PCI devices by 
>> default */
>>       pdev = NULL;
>>       while ((pdev =
>>           pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>                      PCI_ANY_ID, pdev)) != NULL) {
>> -        if (pci_is_vga(pdev))
>> +        if (pci_is_vga_or_other_display(pdev))
>>               vga_arbiter_add_pci_device(pdev);
>>       }
>>   diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 2c4454583c115..195ec1bdac863 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -792,6 +792,20 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>>       return false;
>>   }
>>   +/**
>> + * pci_is_vga_or_other_display - check if the PCI device is VGA or 
>> 0x0380
>> + * @pdev: PCI device
>> + *
>> + * Return true for legacy VGA-compatible devices and for "other display
>> + * controller" devices.  Some firmware-selected boot display devices 
>> expose
>> + * class 0x0380 instead of PCI_CLASS_DISPLAY_VGA.
>> + */
>> +static inline bool pci_is_vga_or_other_display(struct pci_dev *pdev)
>> +{
>> +    return pci_is_vga(pdev) ||
>> +        (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER;
>> +}
>> +
>>   /**
>>    * pci_is_display - check if the PCI device is a display controller
>>    * @pdev: PCI device
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


