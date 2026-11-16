Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794866906;
	b=TbLoNl+ZSdd6z/3VXfOiJVgj5+RL+np9GBtL397GfgIYScnMjuXXjzKBf9OnqrkQa8MO
	 h7kJud/86foPO7Nm/WACSHm2API/CD7BSg11u6JuH0fsOJ8WVjyCe/qyms1I4/aK05zX9
	 K9SdkIqKfw+ANOPf8+p10tLLEJo3fKn7MbnVva6cBKDDHFTrA03u7lydhLbOZqvrf3Kpm
	 GIzyZZGclwO/a9EoR88/wtF89NwqQO8LRLU1chDtg5jQvwzsn9Lpy4ah9m9D2pDzEIv+H
	 I1aD8gYyxLS+TRPlF/eBYynfGU2t8znJXRqve0rBDyFmtasJV0mrcYKoOjWEoQi2Mpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=i+u549PmYZsY6qpU+DC+SKjR1dv37zUfAcYaMhaiLBo=;
	b=DlBf9W6nNQ/SITp7ikGOBqIKSXSsAH0J7zcp4/uI5USP+byif3Lq9sp3KJPL+3jWKX9u
	 kCldp3Z58x8nLa7qvsvm4Sdb6I7Iut62V4GFtNX74T1DJIZSw/mo/f4RhD/Y6D4lyeByI
	 jscwF38zwXEru2dVXWeC/B1xRi5hEivY0XLj8AxCOYTgim7+ORm9mI6wbLDNHYRfi48VR
	 sOy+4nv2tj5wmTabWGEApJbFl9hrP7eEeb+6TlKggztvi/QZqYJs+evBJeYA3BfAliRe5
	 XC/HNOFXwBiS45xXccbC8r3t/YsLWF9YJq2HJ4gFeolfNh//uG//NJH93gkSE6et4mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7VDE0Lu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA885606A8A5
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 22:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA885606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7VDE0Lu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso203130966b.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 14:08:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794866904; cv=none;
        d=google.com; s=arc-20260327;
        b=j31dFIcx8BUzlrvs+llAtf2cu2UFT4lNWCuxSdYHswmKSynokKQOF9hI807v/gjK4Z
         iuj3UqmTh6g/3JEzgSddKJehmIrH8+qyR+ecps68JKvSIeDmlenHypoRFXc18DZPp9B7
         3oGamGa6Z+SVmm2Yq6CU3LLk9CuT83TFp2B/ukm2ubpGvFZLXEyLvmC7x0qySumsNjjy
         8yHZQ1yTTYWtHgJg24KPSVTZ8Khk5QCOzjZYRf8CJrkig0uJ1VfRYATVJEWHV8cZJEIb
         H9swx/8sS8ipgOtTvUMGTCDZLHEwm+N8RedPvony8kL1Z1UgqLelVlY2UwMdK+kzLdjT
         f0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i+u549PmYZsY6qpU+DC+SKjR1dv37zUfAcYaMhaiLBo=;
        fh=3MnadVPnqv2R6obaim1Z88nRc4hC+c+yrqGOg1ts2SM=;
        b=FVreYKsSICz2Nu8hCg07MQf9mirwIWwj5aAmmgsm6T8bJ1htlZVVqMWNgbW8wk3H6P
         AaZTiTnbS8UA1baKo5TRjTNe9h3n0GE09guXxcQx71uO0D3UCnUGBxwbDoBLuSeuq5Zh
         PLHHKq6mq8CdDYkCxwv24pNK6DpkT5MFuAG+83lOttbmlqIhN65TyHM+m1zlQasa2ALP
         ckLbonO9n9ujEd2QKFehyAJ+fs53s/vyCamLyzpnK+M5YGeJww9n/PSS/icfl4wClMDt
         xT5hxqII3qvLbreIL/5U0JayfYPYYUZTscaFCo97dmKnFqBm2OJ/qwLd8bvsLazfxkYL
         qC8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794866904; x=1795471704; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+u549PmYZsY6qpU+DC+SKjR1dv37zUfAcYaMhaiLBo=;
        b=b7VDE0LuEhaO1BSmQTnRF8IniMQqmqJdY8HFEwCfDiQxfFIGgWy/2IDS+iesB/nESm
         rZsekcxazK81N/3kmm02UV0+QQaJZj6bawX+4k6FVXdwh2+35D9hFnzquKg8S5a9CuRt
         qobKUGwfylVwL44ug9AXkc0uyn2Y6HnUnhrRGusraHL26SydKKc7BB3/uA7SPfVZ7z6d
         Ha0aMLXOIFHAkdpVusbBF1EZut80FQcg9lGyn99f4EUw/ZA//oyvDfPKYEmWtu0e4JG5
         JkV12luzSnwI98fyT2j2uWljepSknzdmblXPRwUUx7Qud/3kZv9cY7FIK2hbt5Qm8L3D
         Du2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866904; x=1795471704;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i+u549PmYZsY6qpU+DC+SKjR1dv37zUfAcYaMhaiLBo=;
        b=OmPAeVMZidmSnb5+wOlsuecXWFXaCtgqUFsxVAsjMX6mLwvkED2N+wSnYiTD05HmFB
         VXtd03nPCMRmvvLIul83qHsYg9ESZqWrBveA5LSvssht9EeXMhCD7aTGZubPgR07o01k
         6zIcU+VykDOfJunDWKCqtIPOl0OKhH28QLkxDJXwSdpL9/B2qtGj+5xsKjumnXIYEmPP
         SbEY9Cwvs2Bj46u2KCV+1q+LFspfkdNxMoylp31edxhw+jTwK1gq8VlVMWVIGOtFl8o0
         ZctN5p+bToQlWj+rtpN704BTZmHdu67eoxWNSSKveL0MpPnpN2tiXLiIAEf81lDjz6T7
         B32Q==
X-Forwarded-Encrypted: i=1; AL+hErE+8F4p4g39llsL6nN7HzkARrECXSyYbZh7pSiqib+n9e3JSas4hldd/9QNPC0VwkIL5+b9jkD5+FY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8A1MBU2SpJqx7bK2rFSss5r3vIUZDOS/HDYVC13pN40LLU6DKC
	oz+/Ns6vqF48nkmylJutgI0JwJSmRY3s3jVUiJFe0yNo4p7MJXt5iyXPmCw0RcpkA3zUTJ7KeDg
	l8Lxsz4CyWm2TC/2E1W7APyhxclveUHk=
X-Gm-Gg: AYBFou3yipUyjFEglz0UhUXQaSwe0eIuzYwf9GVN7z9q/kz5m/VmjpRIrKuVDfRxNrd
	+eJ3M4MQBFM7HjulSyArNBTa3K7d7sUbyqDvQixALT0zOPBsAvjRbuGO7oFwRztmWd8+UygtaAt
	2Cgcpt6zLrEFfQMToX9T/YrFcc+rEm4/HT5EMhws2Nb7+ZxKCz7ykvYa9Bjme8K4Vp0kNQLwQQZ
	OHXtCs0dW5u8mcKJF1A8X66gKWtd4XlZCtt+kRUgFn6MNwpaUryFZiFtAzt6tD2k9zw3yTrGEL3
	OvekRm3hfEuqnbYTY8twsRS28BZNSd1hQkbajcmlJD22kK4OA618xa5JRpeVKvAlyLPbK8LlxQ2
	bMw1+EZLs8ihCHIRDSoQinA17JHjV0t1UlnkhDlJGDvcQZx/i/NCLcMybtco6yjTS24HWHckC5H
	Rm1M97Jxkd92UHskRogMfo63BT3StmO/6Wkz/uJLn53ni/M79U1qJWFZiCwqzCPp6ZmPE4XHEer
	eySvvMX9dl5o+0b
X-Received: by 2002:a17:907:d20:b0:c49:df95:fd0 with SMTP id
 a640c23a62f3a-c50963ffe1emr1036693366b.48.1794866904124; Mon, 16 Nov 2026
 14:08:24 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <9ed2d8fb-fad5-44b3-82a2-0021edb405f4@gmail.com> <avt-FbT69lemI4b0@wunner.de>
In-Reply-To: <avt-FbT69lemI4b0@wunner.de>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Mon, 16 Nov 2026 17:08:11 -0500
X-Gm-Features: AclHuK_ZNfer2RnVSrgjN_8SjUD6al7lDk9SqQU4Ps_4AtvEs8wiMTd_WnnN8Ls
Message-ID: <CABZrw2EEDCg3CG_uF40Cgdwabc-xQNHMHjh_KtqpAV2wrp5F3Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Do not advertise DPC on ports without an AER capability
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Darshit Shah <darnshah@amazon.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
>
> DPC does not mandate AER support, so the condition in
> get_port_device_capability (which you're changing) is correct whereas
> the condition in dpc_probe() is wrong.  There's a patch pending which
> removes it:
>
> https://lore.kernel.org/r/2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de/
>
> I'll respin the patch shortly.  The patch is tagged for stable.
> If you can't live with the error message until the patch gets
> picked up by the kernel version you're using, replace the
> -ENOTSUPP with -ENODEV to silence the error.
>
> Thanks,
>
> Lukas


Thanks!
