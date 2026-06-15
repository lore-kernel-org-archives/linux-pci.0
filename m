Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D903AFAEA
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554019; cv=none; b=NqGNPfE3OTGgrDPoeJ3PpfNjmOrUF+bZQAWuW4JlV1Ejp0tRQqHjtkXT6pDDrF4PF9pH9RhHwvYaeeOkxHfZ78VR85F17ZYi8d9PrYEmHTcdifPhFedG6rEAAHgdoFURamS2wYB2CUlTgGwc5tWxvdo4xhQQ7C/jS/Kj4YU8XLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554019; c=relaxed/simple;
	bh=sCnrLLtndgkDFwEuy5w0t6Tj9ai13fipC2HTsKV56lk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TplLdyBf9w6en+sCjGu6lpqz1YBmy1/eoX6Zgd1aomVLr2phsXYC9XICcRVMBFhK4hOmeBDGxDoxNex5beUUvvIgTOELoeKOSOEiYtmKe7YxHFweqvwUmGrDPA59Rf5tm2WJc2LCltZ7QunNFcnLY0WjrNdQR18hVjtUHTUnqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg75r9E1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg75r9E1"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177945a279so43282481cf.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781554017; x=1782158817; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbIDrXLbjAe2J5wNsQv3S9HqiJA8DN79qlIMR4Zc6gA=;
        b=cg75r9E1bE4r5GxygLILr32gWquuO0oNVeNDDst96qY1kRD8BIey0TN+ExBrWwbWko
         U9Tc2bUAk+pm8f7KzzAobWvIYKDTdgNgKA6gjArUoDpkDzUX++baVyjzr2GDKOOOWaIE
         H81RY0E2LcTiZxMdI4ye/4IhRNj7Nd4UlKl5cjmMaHO+5O2fdYvLSBpGupIW6gagcGRM
         2inpG9Wy8JRCX3flkNh8Jfun1xKQELYJCJQ9V0x+Uuwo0BSNpA31QiiSrgEEX7nWOOki
         swLcBNu+cTO9a3yRls3mIzx2r7QWcC1bBy5SsLmmMAjwnH61acxoF6J2iLbbEmMhXQWi
         dwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781554017; x=1782158817;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbIDrXLbjAe2J5wNsQv3S9HqiJA8DN79qlIMR4Zc6gA=;
        b=O6nBPbNXRzGTsK85MbY0JHxftnmYbdr68fsmsEwKmymwIBg5DmJDGgzZ60+xIdjpqx
         Iq71XSp7w5yqjsrOZsOv8XB9BIJ3YlKufVakG2I3oL/5rAl9X46TLKOZAEncV0CQdys8
         RiX+U6LCKUfD4nb4VKDyPh1pRu655SGkjHhIQU/dQ080mE+N8PZXZAD5WwyLVIhN6cpe
         25UnaKdyiWY5DMgQm1428NIkdE/j6EWe0v0oumGXPsvPTpYd9PsvTBDb+FmbY628NcUH
         hHPKbtvNyHY0j1W5V1a+wVRrafBLkTcw93m98509dAgnjDf4ffxFLJJ+SqvDG96HFi09
         xs2A==
X-Forwarded-Encrypted: i=1; AFNElJ/9ovNfjk38hggmm+geseuUTJPTUMlskRzCqA7yuraw7jCbdQSva4hcpv7PoDjG0M91SaA83UHmxFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRci1wLEbOqpIcrxE7iHDjzRPgOEaM70WjC6HnAST483Htsfn
	biuDQ8qZO0zq/Ep93vww013nrPSbXxpm14yUGeSS1kupyV+3si2dsF25
X-Gm-Gg: Acq92OHllsZ0KaCM87Ch2/957R6zw6aDxHJHq95Pc0DRtPRlJofYMmsZXztwQpUnBTY
	fy9gMo5eQtIhCnxrPAwgjxLCFNE5Zio21DtCWkunhODQYtqx708YsacCMGWxn9U0dvseJdfRIeg
	noDihSpgaO5c8BwERifTLN+6O0lY46Pt5KZsk/HYLL389zKpMGM6IJXfdBhcxwSSw1rOqhAoylc
	t5oxVNEgBu27KpS01lVXaY2MAytbLWv9nKeZ7Ycg/IwjwpviJ8Q3Hfogf75QLu6wPWj60dUFOBa
	tGJP4qBO6o+K9NSS3M5lE6vWIc+wFB1dDg708gPrjNXr1GuCh40atkRdt65AnuJPhzIP1HoMfK5
	BL5TPogCnTGt3QPqUw9wCuuxg8qOsGG9mB9igV5vwnslZR89y5vbiSZ8s8fy8F3I1SvUF+ELdD7
	UXFVk5AUsKZO/KF12CiFN1SUDM337ZBHzh2Egc/8Oir7vVrY1fVsfk0g==
X-Received: by 2002:ac8:7f83:0:b0:519:8ae9:4cd4 with SMTP id d75a77b69052e-519919450b0mr7934781cf.34.1781554017299;
        Mon, 15 Jun 2026 13:06:57 -0700 (PDT)
Received: from smtpclient.apple ([104.39.165.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f5b8d9a7sm8704636d6.48.2026.06.15.13.06.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:06:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] KASAN: slab-use-after-free in pci_endpoint_test_ioctl
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <2026061553-fifty-qualified-2e04@gregkh>
Date: Mon, 15 Jun 2026 16:06:26 -0400
Cc: mani@kernel.org,
 kwilczynski@kernel.org,
 kishon@kernel.org,
 arnd@arndb.de,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7255A69B-2D3C-40D4-878D-9C32B52A86F3@gmail.com>
References: <178144969601.60470.7358419009914000395@gmail.com>
 <2026061553-fifty-qualified-2e04@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jun 14, 2026, at 22:39, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Sun, Jun 14, 2026 at 06:16:39PM -0400, Shuangpeng Bai wrote:
>> Hi Kernel Maintainers,
>>=20
>> I hit the following report while testing current upstream kernel:
>>=20
>> KASAN: slab-use-after-free in pci_endpoint_test_ioctl
>>=20
>> I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 =
(May 25 2026)
>>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/1e03464adfefbb75fb5d8112691e38b3
>>=20
>> I'm happy to test debug patches or provide additional information.
>=20
> As we are drowning in real/fake/unknown bug reports, why not take the
> time to work on a patch to fix these issues as you have a reproducer =
for
> them?  That way you get full credit for the fix.
>=20

Thanks for your suggestion.

I will try to look into this and understand the root cause.
If I can identify a proper fix, I will send a patch for review.

Thanks,
Shuangpeng


> thanks,
>=20
> greg k-h

