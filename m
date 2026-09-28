Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6F248896
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598726; cv=pass; b=ZAUmD7ZBiWNhiQB4c+XUSPoH/P3S+BbzKIYP+FQM61KAIRBVmr/odCN9PD2No5hxRYwK0XQocSrk9L6ciBg3oBB2gLgv+koQ+04R4rR8fI5AGW7BlCJWrPr6kWDuz1Pzjzr4DbNlti5XDNt5rz9cFgoOCMsnP9udQnKZRApCtss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598726; c=relaxed/simple;
	bh=LvGdn2hkiIeEdQO/+4P0N6T1Y/jNQdIt2aZQDR7H4Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYjiW0Y05js+GPbaoqSd57J3hZg7/GPka9bu5QcR0/1tTszUch98mNDfDZRSx1uVDxq+SPs+wcOnQwJKA5Za+75HqKgaz0K75Z04yAIk/K1Bw6kukkTvMFv6lNnIl80f3btYtEKGeU/kcHpPN61Yd06kuM4ctev1modoUtt5nR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsoA/ObH; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsoA/ObH"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6755a6109c1so153929d50.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 05:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598724; cv=none;
        d=google.com; s=arc-20260327;
        b=swhbrTtxD5jHG/1GlXpGiZf/FMZ3XCjwe+nNn7T65x/C7U9EevW5fZGFYN1zN0cS8e
         mQ7tf/+qb83ZPuXwtwPjx3PeecmllGn9WfdT//jQcbsBNvKBvOVkoWI+4Ie0IT65NnS5
         UXiaQ/ShE72j6TZUYfms8BJpaxkr5BPTeCmRPaTFVmdPDylB+n9MDP2cF/jwleVVY+Ve
         wdfGBGgDmcWatuHSaRX/rNijIRrkZpi0+T3Ngu0rfVK1eLYKn3sY3/Qo80jW1y6Vh58D
         LcvwVlgptLc+Q1qxRYH3xPUBhYhbShN8s06UPrxvKFi9gV3XIdpgSygOT5QUJ9IxYJ52
         F16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvGdn2hkiIeEdQO/+4P0N6T1Y/jNQdIt2aZQDR7H4Vo=;
        fh=3G1laKckcayz8RjlMcbVoeHQaQkhxo+Owo/mAeJGwlk=;
        b=XXlT90lgIb4KiGSy9t3t1z/NGuzDhOK+7TqvojuN2gpt/7Jah8LIYwspDJbX2KT4Pe
         zpo9Ed8F5weAofIkglYVoolzXHYufXNoQncUbCWvwneKlIdmywXTf08v8q4RrsFvc0uX
         Ih2Ba/+K9d1TqhF8XVYQsOl29CVzlstwbL6ZJuYVrDqsn22vHU5CHJ4+tT67WPoG7T9e
         ffWpro5i/St4t/hWNmDhP8uAKGvZTgKrJokZZYhXyQVw9xb2NKCY6GmynPBQYw040QIm
         d8536+oJTlhwaIw53+qUQ8PwsdXrBmgZvw/7a2uWzTdS8zFAv8JQMBpUkSy4cGQTkkD2
         UQ/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790598724; x=1791203524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LvGdn2hkiIeEdQO/+4P0N6T1Y/jNQdIt2aZQDR7H4Vo=;
        b=VsoA/ObHaVQQX+rJUBqac4OF7VxPSy/ydlo2HtzqPni1a/loImcDn1e6hmtfth0NwE
         NgyaP0KUfC0ymfqqMorkSLhvOq8/fXlnz5Hc1y/RR8uFchWOsE9gbkpUFDPnbM15873K
         fYlg7DOcxgBJU5e+1rGWr07Kl3VBbMkbt2W0bnoRLowoQWH7sIjuvGxyIuulxwqLt8LS
         5zk8m9q44s0IDIT1kTDu5cj4vDqptBMDQm5m/1w3CTvbWIvSNF9Ea6Wm3NIzy3+2yCRu
         qYn4dtcyGq+WdL+Fg43HwLAQjso1ENrQgDEdRhpEWb3Xf5Xl26TLCwqPIBjfOM6cntnG
         XMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598724; x=1791203524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvGdn2hkiIeEdQO/+4P0N6T1Y/jNQdIt2aZQDR7H4Vo=;
        b=x6oWrW9pMyWfVryCrBt33igbRB578DdgIZ9D3cNHCheeK7T0HuhDAdqjt98DLHLDLC
         mgMHp8yNtIdtlq9NR3TWuniFBuFsNUH+0c212vmrWe1Eu91+NEWP5OdDl5W1vAAieDgD
         aEuRMvMP3BNP49Y7X7ba7SsGhEWKOUxulYDI368R1tECfOL8W218VwvJ57n/5mM9CZgx
         WBCawX3riKLDj5VwslEn2RwkQ/sK8I8vn1TYaV/vWkAy90oe5nPhvvIRjDzqkT/n0Our
         QGaIZ93HQyX8FANK8AePBlx55VX9LJoGSLbjBawaFTvB44e5Qeh5iEEZg3ksx7STGGro
         HU/w==
X-Forwarded-Encrypted: i=1; AKwUvBzO7uTyZCNRMOupQifqV5kRks+jtdDATmhcEZ1hyfLEAnS7Lk3iuN6X8jQNQBctzHv5WKGTaBMTL5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvJC6RuqpgFRJVr38jP0hFGgyS3GoXJG/0aY3aBU/XZY8xdYEr
	6Uf2b/nmhG6LAryTGvf05+kD25ZIDyGZu8QZGwNZuLlAzlu/uTehiFM3dBleSUdvRe+C9RV9JGB
	7DwqBklXR4hWSttiKyDJ5tokspn+Jvno=
X-Gm-Gg: AYBFou1VIJTN3VNUaIA7XMn7qIc5YMNIWL4/b0sJQM1PXuJnna/I3hIWQ+OTisBFf/9
	sVFeBJtdqcx08bm4OPyJZO7NGb7EfJAwlFLEUaBMzABV3jcGTDYstqpKSd5YLZVCyNoiCPjyh9k
	RgtTsmqMvtw6YilR37CQmvNKSf6eL4/ayDiTXlAdNe3IixAx49VcNO75sPsvHOXVLaVw6CIgKbA
	NXXBEMp92b/ekPQ1loRxmaeR+OXsD0Ay2FBoyJg7fzFKoV59VNgkT1c0EPr5RyDDF1r356vJgTS
	sxdxOKxJMD0r090e0Acb+h9gtajjPJZPfQSwXRl95kdRX8Lu9izCZTGJoVum6FYfZRUMjKEQ4H7
	jlWgznz1XEgDAPbN8rNCeJKbshnKIOsEEgSLKZveSLn2Yyj4yWEAjy1M3
X-Received: by 2002:a05:690e:43d7:b0:672:a098:bfa4 with SMTP id
 956f58d0204a3-6740bad5163mr2491644d50.90.1790598723665; Mon, 28 Sep 2026
 05:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADhLXY7008e4JA35T2wE8TnJnR_r82RCpfSd=aLBmDh5xAQ02A@mail.gmail.com>
 <20260923205518.GA1941939@bhelgaas> <20260923225059.5c8cf0d7@pumpkin>
In-Reply-To: <20260923225059.5c8cf0d7@pumpkin>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 28 Sep 2026 18:01:51 +0530
X-Gm-Features: AclHuK8NUjREgQIAohkxNSm-52_ycxHjkhDYIqnt9K1ygKIEBhfIimWuLdHG6jE
Message-ID: <CADhLXY65fwGS=87oOtyAi9V4oXjbr8jgJNcSc0wXkVV9OOsREw@mail.gmail.com>
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
To: David Laight <david.laight.linux@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:21=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 23 Sep 2026 15:55:18 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > What do you think of the sashiko comments:
> > https://lore.kernel.org/all/20260809051652.36BA31F000E9@smtp.kernel.org=
?
> >
>
> You could just add 'if (port & 1) return -EINVAL;' to the 'case 2:' branc=
h,
> and a similar '& 3' to the 'case 4:' one.
>
> Did it miss that loff_t is (probably) 64bit on 32bit?
> Or do large offsets get detected earlier?
>
> David

Thanks David for the suggestion. I have send patch v2

Thanks

Deepanshu
