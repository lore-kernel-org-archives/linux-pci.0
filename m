Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EF568FA9
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930654; cv=none; b=Wy5mNGAVCUyo6umaD2PSVt0xIc40/fKpXs2z5PO1/RYkNG+PqsNOPe5KaD+l56D7wMRKbaZPjg/mjUbVuqe48jQ1YMt6yoVAWQmld7VNAKjVJ3LSGlse0SWTh0zKy5GfKHuiYzen3ZVDt2E6hZReWGHqGQBdGtFpMlX+btS5jZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930654; c=relaxed/simple;
	bh=paIc3wdkCGaMzVDDLd7bcfCDFTMbuVaWj+iMPTcVHWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moO3Wq9KDUIZ0/4QBE1rEL+MEJ/+bK2b1XBiOxJ79/lLzXoxdE/Gt7/wiDtsalxKW3R8uFfdr0d6o2CsjPFPGbGq4z329opClkvYdGWBgVFHwBcS3LTc9CphNAaeL0ZjkTCl1pFnBfeq6NdHkIR3irSRm9PH8C/6EunzVk75rZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=wsOrBQWF; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wsOrBQWF"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5339199d8c3so34466031cf.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791930650; x=1792535450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15UuH/nH7GbuaRGYpdfm5TKB7gfNnyxt98L6IJfHb5g=;
        b=wsOrBQWF1Io2wpApJXKt0YDCvqRam/KVW1uR0Chf/LbD3NuJHKHidVarSVSLy8TleG
         100AHIzypZU+WlKhi0ru+KgItIZ0xnFffrFEAx/C/yfraPLSxAM7HA6yyRUP2bFu42ZN
         2etR1QvxQWLtllJvdLQGAyPJrJqrg/RdWPs6sTMjiu+Y2flUc5+KQ00ac/sdGMX4jQYh
         UM67bnjlowUXzbFoFkhaDBjwqyrHFwd0CMfhBffGnhSk+zhfHBIqMLiAhze25QOduCHT
         bVenDUW1OAlG1/ErkWodcosmkYW381Ehg29ODYi9Qer6Tl8gra1jIFtRFGlankLZ1RI0
         SaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930650; x=1792535450;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15UuH/nH7GbuaRGYpdfm5TKB7gfNnyxt98L6IJfHb5g=;
        b=TwRJvnvODDkRtksY/W3p7pfA+ly/1UUoVjI+7J8Ab7xoS/E1u8mBfKznOQTK7E+V4n
         ENjj8457VYiYPbech1XLHUXZnhGEoQ4Nqc3QGBvlXuTU9oS5ttvc32gIrvMNWVMJb46C
         d0XyWiOEcWDmH9MaJiAAJiEvSLm3Je8YR9jzXgXqThauW1SkPPP6hiowS8FrYuv6kcfK
         MiKenKeDjvg00DvzJi9MXtdGHaSsSqA1h+n5B/vKuCtU/oyF70MjExp83zRZO97b3vX4
         v9tYnBlLYLnK/mZnQvhlyCObuZnhXrLegnxIiftI9UjvJc2oBio7709UDygEdhRXu84T
         5j5A==
X-Forwarded-Encrypted: i=1; AKwUvByynWssR7VnZq1CCHXKf9SMXTBuqS3fYrvEqD9G1v5hG0q2BrlTrOFN1MRBUkDRQnrp+NWs3ibZF30=@vger.kernel.org
X-Gm-Message-State: AFq9FYILk41Pm0pO6XtoPgVBXK6PaBp0UouoYiT5lz1RISomqFyg5LSH
	Wg++FBC8owPUWiLXVeKH68f7GjF/w2XDtxHWgb/SyIzF4QDkWlfO4TgJjuAWsBzO8sM=
X-Gm-Gg: AYBFou3rWrrC2I2NB87IiPZ2KqQhn4FPUyFXTGCP4O8XG4aarenzDYsjtVkSQKXpNqt
	pmEkXO5RrGIeHD0LAlgGQs/VrmuPn4d7nN5QsY3FCtmLaqsGJIlanjteCuaL3q4jP0osnGIPGQW
	uS3OHk78pvFl+lBcuAU4zVgPNUEDtklCarNyl/I17ROccCCFikQZXa5wA3JWrOPqM24ltc5M0e9
	4MijCk1JTGqAi3jwJElXacxNtWPR0yJwDg19bQKXDpfZeGIFZi8F8MVqZgjBlTNZdC1BsiPa9mc
	UmBvQtLdzzGmSkw45LjCfUPqu2FoScl5lk8D5BIBVbHUXH4YkxzIEgRivRtBc9HCLLukL3Ar+7L
	wRHS1DUdbjq0oXdY9IrvE0JJzm1i49aLd31AXjmrImSvmoUjOW//fYgo316oR1pAaRQfyBn+Oud
	KyUuZDjd7SGwaL2yfQViDE0ISYbZ4602CwIaIw9ZDQpDUrXCFaYYMUDC/+qPnx3imroPlmREk=
X-Received: by 2002:a05:622a:110e:b0:535:a5fb:6449 with SMTP id d75a77b69052e-535a5fb69bamr231387611cf.67.1791930649810;
        Tue, 13 Oct 2026 15:30:49 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535d43f09e7sm55712371cf.8.2026.10.13.15.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 15:30:49 -0700 (PDT)
Message-ID: <a8f7eb6c-69d1-468e-b7a4-7481e429c1cc@riscstar.com>
Date: Tue, 13 Oct 2026 17:30:47 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] PCI: of: update endpoint ranges dynamically
To: Andrea della Porta <andrea.porta@suse.com>
Cc: bhelgaas@google.com, lizhi.hou@amd.com, herve.codina@bootlin.com,
 daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924222444.1351466-1-elder@riscstar.com>
 <ase6toUhGn0XD0v9@apocalypse>
 <223c5189-bfda-4c63-b09f-4ebd01bd144a@riscstar.com>
 <asju_HpgXpIyAFdf@apocalypse>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <asju_HpgXpIyAFdf@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 8:41 AM, Andrea della Porta wrote:
> Hi Alex,
> 
> On 10:55 Thu 08 Oct     , Alex Elder wrote:
>> On 10/8/26 10:45 AM, Andrea della Porta wrote:
>>> After a quick test, it seems that it's not working out of the
>>> box on my RPi5. Let me investigate a bit to see what's wrong.
> 
> I stand corrected: it works perfectly. So:
> 
> Tested-by: Andrea della Porta <andrea.porta@suse.com>

Sorry for the delay.  I'll add the above to v4.

> I think it should even be possible to tweak the static RPi5
> DT in order to make it work dynamically with your patch. Can

I suspected that your static definitions *happen* to work,
but I never took the time to confirm that and understand
why.

> you please provide the relevant PCI DT nodes (from PCI controller
> to pci-ep-bus endpoint) from the output of:
> 
> dtc -I fs -O dts /sys/firmware/devicetree/base/
> 
> taken on your reference board?

I'll send you that in a private message.

Thanks again.

					-Alex

> 
> Many thanks for your work,
> Andrea
> 
>>
>> THANK YOU FOR TESTING THIS!!!
>>
>> My hope was that the recent change (to avoid doing any
>> updating of ranges property unless it was found to be
>> "empty") would avoid any trouble with the RPi5.
>>
>> I'm eager to hear what more you find.  Please let me
>> know if I can be of any other help.
>>
>> 					-Alex
> 

