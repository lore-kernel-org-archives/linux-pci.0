Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C02989B0
	for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786771812; cv=pass; b=BhTOsBDmfspPLliSHDgKeELA2i1gpgX3DqKF8ZSQqM8Ied9pModw49BZHtq1EvevqFvUA08W+rxWYtMUrZt2Z5ofrxGunwWpTbhdXrQPhCBm7B+zvyb/GdG32J7yHoEP73n0gGgO8BxFhWZ4bmhRDOGoApo/V+IR7a0jqMlzOoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786771812; c=relaxed/simple;
	bh=ZIxboLPhODJsbYTv7g3HJN7Opv0OyGOS2xa1MqbvWu4=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CDCsfG+xeizgBxv9hl09Sn4W0spJTvWuVA1tDrkyoU4JlnhL0k5eKiHKoHs9Ba0tcBxZYlbPdsq2TJbh8bOA5TT2Znu3Ww9vAAv5zmVhFofJUAyUvPmWvbDiLtar1TjATwE+pbWwMprr2g+fzwvnLDsM4PrRdZGPUv+dgEHEeow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIfzCXb9; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIfzCXb9"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f29ec73064so9370816d6.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 22:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786771810; cv=none;
        d=google.com; s=arc-20260327;
        b=d7eblPj1tqZhonMfeAlARq/UUB4B0vf1YR6wS8ek01poetC+gf9Vv24pDAYfOzHTBO
         c9gEanu/bj5ZLBJr50QqVraPXWd46x4j8/aBWfbDHQIhGD9rXOakfzEtsNNzxOAhI+Ra
         1HdaQNiRD5qV6hjp+aKERG9sInphcWO8aeMrdMD//l49VRK+4odA3YSCJPPu5HeoQ8wQ
         zCz6D/876F/O07SgIJDEOZNHWImsYjZdLRXexuKVkcQf+uCiZVw2egLLtrEZzHS/8q4k
         vx6wXypkf730w0sEhC3vAkPb6tnFs0LPJ3cS9YgaTsISW3849YpiOJK5WReU+iiG/Fg5
         W37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=ZIxboLPhODJsbYTv7g3HJN7Opv0OyGOS2xa1MqbvWu4=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=B/URxm1+dqvSHMtVaFOFM8bESD1MPkahssFNjJL4ACb8RBVNNcy3kuTTiT5H24dTh3
         wPCSLmiolQ7rtokVxfrxf5A0quk9fwPXrEifQiDXFVZP1XHVvSvxjfGGBcwMrb1dU5Fl
         j6WrTC2KFUtoCb3jibwQc81oHwnbNGreaa0DzNgl2lJyBRSz5B/HoNAkX7CPcln1tVXa
         gQK5jlDqhxJ+BGLRnxKKikK1JoFTnah86crGgU3b0w07cHjRxvtZruDW26BesiLrpOJv
         1rw4+0GqR2BLUpvAmE98Sb/DgMfIEgvurvWEIcB0fo+HwkGOVg9TKRNB7SlnOAF3yiib
         blhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786771810; x=1787376610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIxboLPhODJsbYTv7g3HJN7Opv0OyGOS2xa1MqbvWu4=;
        b=eIfzCXb9BZZQU8AluEHa4qRa47c8BPV4WLgczvcT8oPGQBTwLaBnMn3aOOxco994pb
         HJ1imWHR6pkFe9v1jy/34whOSir5CK3njh0YKpuohRhO8LkpyvLlbjXwlnqERpMD25su
         B4oES2WblPK+X0VeJv+/hBqRyhEF5STJiElxTEQ3zm2x+6I6CaZS5iCOh3rXkrD3zK4x
         ZN3zDIwZzdSGcx4cBO/o7np1UBxbrtfkH8/0W4bA+zJhfd3Tm6ES86hbpJygGp5hGMO6
         Et+13TcvHSQImAxqpKGozvAPibin7gFfGHDb2MhTB5iVXW35WKbz68QZw9zqtuhW3ykc
         i8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786771810; x=1787376610;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:references:in-reply-to:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIxboLPhODJsbYTv7g3HJN7Opv0OyGOS2xa1MqbvWu4=;
        b=YS6j78YzLB5wTJBT45HBbDVR/XJyb29612MITG+uBFocjrbqaW6D2UEdPTE1rEm7DA
         MhU9r7tFwGYr3t/PK2EjSy0nVf6TZ+M/D5pS+n+fNB9raxfq/QN4IUKKpcEXL/yr1uLC
         vSzlqUjgpQffXzUKOIinpa373xQ0dGG1wjhcYFLgBL61rpxhbW53XPSiEXXFpJtsx07+
         nti1VBikOrzpF44vN1pInPeG2NgeExdksl+uQDeh/YVQ1Hs/vFu54kLj/Rvj8W2G2yM5
         3tPhbNqvlbipUgmC+XBDLHA2HCpWckUOGKicpt1s/Xvaapji6yIjbwe5np/CTBgCK32G
         fBgg==
X-Gm-Message-State: AOJu0YxrMJwUBN3Vo6TZzmyj1EIgoM8QdALB2PiBO3cQdTzOM7NtNjQA
	/OBbFOBONnSLAoTc7ZnoWELF+bG1rin5FQM9JEyoTTT+M68XlFPnBcoP7sQ3ow5RMcDaSw1ajE+
	w/AWvDK5MbtrOn7Jx43u9+aIq7MiO4Dmo40If
X-Gm-Gg: AR+sD10VZ0FXa+cMUEVwUZ3yqK8LJqffi0Zh8Flccphv2w5rZAf0rkdfjx0v4qoWtac
	0tfyVlVMVWs0DMtDvQHcuFRBg7plH22u89402SERDOYzie8pSXsNMz3XS2MbIuWgfcvpGDEz1OV
	NELAH18eXqdUztLHEIWRmaPWhmwN1sDKcMhV2WJSMdychJrVPhb2qJSj2osvDYyJ+V4K/dtnrys
	XqfMAbTzLfo1FhCMIkafF0EsnfwNpJm44U2Lip8KRRbnTu633C4cxsgTkges3+eVU43nAXlW3fg
	3+wiMjEwfHpb7R/TP6B8fs51h0m+TaqrHeAYOVXsXRc5fILoDiVIlaThIFbTXvGIGGGz6xdBXQ=
	=
X-Received: by 2002:a05:6214:d68:b0:8ee:cee4:7497 with SMTP id
 6a1803df08f44-90a91de4849mr105261626d6.16.1786771809658; Fri, 14 Aug 2026
 22:30:09 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 22:30:09 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 22:30:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPbDjBakdW2DdVoegF94Hk8w83oh4X1nCF8brQ7H8S1UZJwbng@mail.gmail.com>
References: <CAPbDjBakdW2DdVoegF94Hk8w83oh4X1nCF8brQ7H8S1UZJwbng@mail.gmail.com>
From: ego RRR <egorkara@gmail.com>
Date: Fri, 14 Aug 2026 22:30:08 -0700
X-Gm-Features: AcwNN1UjMZm6-88MDs7HDsPoA5QVZMUn-hNI9WRrjFzriZMrclKw_izkDnkgzhs
Message-ID: <CAPbDjBZ6W=jGaHV-EWXmVwt8d99037j3NOJQ7pWQQTkHura08Q@mail.gmail.com>
Subject: Re: [PCI] AMD RX780/RD790 root port and RX 6600 upstream bridge train
 at Gen2 x2; RX 570 reaches Gen2 x8 in the same slot
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

0JfQtNGA0LDQstGB0YLQstGD0LnRgtC1IQ0KDQrQmtGA0LDRgtC60L4g0L3QsNC/0L7QvNC40L3Q
sNGOINC+0LEg0Y3RgtC+0Lkg0LLQvtGB0L/RgNC+0LjQt9Cy0L7QtNC40LzQvtC5INC/0YDQvtCx
0LvQtdC80LUg0YEg0YjQuNGA0LjQvdC+0Lkg0YHQvtC10LTQuNC90LXQvdC40Y8gUENJZS4NCg0K
0KEgUlggNjYwMCDQstC90LXRiNC90LjQuSDRg9GH0LDRgdGC0L7QuiAwMDowMi4wIFsxMDAyOjU5
NzhdIOKGlCAwMTowMC4wIFsxMDAyOjE0NzhdDQrQvdC10LjQt9C80LXQvdC90L4g0YPRgdGC0LDQ
vdCw0LLQu9C40LLQsNC10YIg0YHQvtC10LTQuNC90LXQvdC40LUgR2VuMiB4Miwg0LIg0YLQvtC8
INGH0LjRgdC70LUg0LTQvg0K0LjQvdC40YbQuNCw0LvQuNC30LDRhtC40Lgg0LTRgNCw0LnQstC1
0YDQsCBhbWRncHUuIFJYIDU3MCDQvdCwINGC0L7QuSDQttC1INC80LDRgtC10YDQuNC90YHQutC+
0Lkg0L/Qu9Cw0YLQtSwg0LINCtGC0L7QvCDQttC1INGB0LvQvtGC0LUg0Lgg0LIg0YLQvtC5INC2
0LUg0YHRgNC10LTQtSBMaW51eCA2LjE4LjM4INGD0YHRgtCw0L3QsNCy0LvQuNCy0LDQtdGCINGB
0L7QtdC00LjQvdC10L3QuNC1DQpHZW4yIHg4LiDQn9C+0LLRgtC+0YDQvdC+0LUg0YHQvtCz0LvQ
sNGB0L7QstCw0L3QuNC1INGB0L7QtdC00LjQvdC10L3QuNGPLCDQv9C10YDQtdC60LvRjtGH0LXQ
vdC40LUgR2VuMSDihpIgR2VuMiwNCtGB0LHRgNC+0YEg0LLRgtC+0YDQuNGH0L3QvtC5INGI0LjQ
vdGLINC4INGA0LDQvdC90LXQtSDQv9C+0LLRgtC+0YDQvdC+0LUg0YHQvtCz0LvQsNGB0L7QstCw
0L3QuNC1INC40Lcg0Y/QtNGA0LAg0L3QtQ0K0LjQt9C80LXQvdC40LvQuCDRgNC10LfRg9C70YzR
gtCw0YIg0YEgUlggNjYwMC4NCg0K0JjQt9Cy0LXRgdGC0L3QsCDQu9C4INC/0YDQvtCx0LvQtdC8
0LAg0YHQvtCy0LzQtdGB0YLQuNC80L7RgdGC0Lgg0LjQu9C4INCw0L/Qv9Cw0YDQsNGC0L3QsNGP
INC+0YjQuNCx0LrQsCDQtNC70Y8g0L/QsNGA0YsNClJYNzgwL1JENzkwIFsxMDAyOjU5NzhdINC4
IEFNRCBbMTAwMjoxNDc4XSwg0LrQvtGC0L7RgNGD0Y4g0LzQvtC20L3QviDRg9GB0YLRgNCw0L3Q
uNGC0YwNCtC60L7RgNGA0LXQutGC0LjRgNC+0LLQutC+0LkgUENJINCyINC+0YHQvdC+0LLQvdC+
0Lwg0Y/QtNGA0LUgTGludXg/DQoNCtCa0LDQutC40LUg0LrQvtC90LrRgNC10YLQvdC+INC00LDQ
vdC90YvQtSDQv9GA0L7RgdGC0YDQsNC90YHRgtCy0LAg0LrQvtC90YTQuNCz0YPRgNCw0YbQuNC4
IFBDSSDQuNC70Lgg0YLRgNCw0YHRgdC40YDQvtCy0LrRgw0K0Y/QtNGA0LAg0YHQu9C10LTRg9C1
0YIg0YHQvtCx0YDQsNGC0Ywg0LHQtdC3INC40LfQvNC10L3QtdC90LjRjyDRgdC+0YHRgtC+0Y/Q
vdC40Y8g0L7QsdC+0YDRg9C00L7QstCw0L3QuNGPLCDRh9GC0L7QsdGLDQrQvtGC0LvQuNGH0LjR
gtGMINC90LXRgdC+0LLQvNC10YHRgtC40LzQvtGB0YLRjCDQv9GA0Lgg0YHQvtCz0LvQsNGB0L7Q
stCw0L3QuNC4INGB0L7QtdC00LjQvdC10L3QuNGPINC+0YIg0Y3Qu9C10LrRgtGA0LjRh9C10YHQ
utC+0LkNCtC90LXQuNGB0L/RgNCw0LLQvdC+0YHRgtC4INC70LjQvdC40LkgMuKAkzc/DQoNCtCh
0L/QsNGB0LjQsdC+Lg0K
