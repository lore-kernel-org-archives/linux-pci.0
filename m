Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5E2F7F0F
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514293; cv=none; b=m6cGu3gqTX8vGX9Ycr1278aBdQHSg4Cv4fCp5hPytxtcWlHbsdG0LtrDjhSTLubXiXurEL3iqL5heZlotLhMJMFdOyMmR3pUHgPvI+ZRwNZq7oCKQ2PD7Gg7ZHmL1n5aSaRgO5x2WRKj10qGzalbiKrLBnf/4YSswiltsc2kfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514293; c=relaxed/simple;
	bh=z2aQvVP3h/SKLEfh0UFs999dp+NOnSePu79IOAVzSVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYVEBPZJF4RcLoow7L0zX4At0D46Wmj7S/enNn6lQymNcu2tzmZ9fo87bjrzE/iO/jiReOynyIR4R6CgNh7qXZ6sMZEGRGV6wonBKPcVVTQINz6i5yutf+A5MqpgsgGkmjr67pAL23bpXoflc8rs4GRdstIC6HBgncql3JAr2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQHH9IBR; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQHH9IBR"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-782e0fc1e55so1681121137.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 19:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514291; x=1792119091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RltOJKgCcU/1lqOOLjeda5sT6T8hfY7f6K63B+K8aO0=;
        b=rQHH9IBRr/2MIDbw4pCz6BXpl0QBJTeK7XSfBW8PNtfdeAGAGPm/Kofn9JxFq9qSQQ
         o2Vtl26fCd9bmAPofBYgXJga+vJLnAlVZ0L6UTpOLAnpn0UYy5HFshL/sa5UxzEp7U92
         1TnvvRNXyyvW6gDOcm/LkcaAZZVkbp1YuLAzAf4L8o/fjzOtJJXfwICwvAmKSY278M0l
         qERbHqByw9OfiSi3tABSt5bJzr5+AbzUG0ypccvR7P595UhUWEtGWgCgWCkyLdyB8HAV
         JlOEj12d47QrVR3mwY8wmSUhw3XWU4wEqygz0pKdy9wrhioNM7bn+h17fLdFn7xDOCL8
         /K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514291; x=1792119091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RltOJKgCcU/1lqOOLjeda5sT6T8hfY7f6K63B+K8aO0=;
        b=USTwhk/L0bQtRdWdlnHjBu+fdUVZGBNmI+ZhCLgrDoR/shefua8Fi/ECoqparolqI0
         I558mF6vLRdA33WUTOEkTasrC5OmfdvFvlUUnpCQ3auTMEwEJ5ytcLVVN2YMsXrlqHLW
         /467gXBaEDsuIxBXrVAri+wBGHOcywy277p8eByAYtRdWKMkwyn+axfoAAtvzqHTocx/
         1uVEoE7z2MYhCNOG+g7JaCUW4afWLIrjvzAD/+64ZItILL3jj78QCQ+TWscOfenNY16C
         gm4+62cHGxO3/fGkCAXtvOOGWZZbDXAFRNQ6sZ+YfUd1mt0OviKymuNXWjgHqc7h8OQS
         6ZVw==
X-Forwarded-Encrypted: i=1; AKwUvBzQDSmkq4F4+vtF22aptJvvWHtTGo42gjlk7NDqBMz135YCXoBoa4Ly7FgAKJZbMnUWkhmdHHRf648=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv1Cy7exdhp6d3Iw2omxMW4oyc/l730rsQfg3iiEusjTNGgUyO
	7fqeSHqXsWsPdbj1IiYgsUfhURiJbyj3JK0rQ0fuuoBH4Hr3/q8ucQzR
X-Gm-Gg: AYBFou04B+1nCgqYANJoOSUv6jIb5LXq4no2DIpjLJaDymreQSOj08wPo1OaT8pJzhb
	uvNjEVcoifP+2OvjHVUhBUj3xEmUx4elaWmeXCpzNKj4D3z9RIhdoa3PhcMeYVbzGN6ULzL6FQq
	qjBpJm+Zz5io2x6efRH3zNHqT8C/SOW29lmRzyF0uMXBvnjD9CHDraB+ftrAiS+ZVpaHAlq+Wbp
	caiBNfEtWzJ13IUVR9rXYPZbKrm856zLrrL4ZA3jp/sS7X0aodoGV/AH+ZovLUnaxdUgx5d+Kxv
	NSlG9yMLbK6CjyNS9VfCW0b1xdXobxI3b+bSMGA7Dev8MiPzqNAnkmTfrZEp8Bfh7iJniGGjFC0
	jq5Hqp0zHEATvkgOdO/LeT7ivwLnZOf3/yu+vN7FKFWXwi/aDkDPddJ/Aqypiq/Ns3Wp63loQZn
	Lj6qAeEFHOA9lerUsHtkF8myNsvQibqs/XeBPGGxPJzBSA7Z1MCK/ah4npEOBXQ7K2pLeE5+beB
	SU5xnCv
X-Received: by 2002:a05:6102:5122:b0:7b2:7490:fd75 with SMTP id ada2fe7eead31-7cb3728257dmr170852137.7.1791514290745;
        Thu, 08 Oct 2026 19:51:30 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9900490dd07sm661866241.3.2026.10.08.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:51:30 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: d@rrell.co
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
Date: Thu,  8 Oct 2026 23:51:17 -0300
Message-ID: <20261009025117.16225-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008185543.85892-1-d@rrell.co>
References: <20261008185543.85892-1-d@rrell.co>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Darrell,

Thank you for testing all three patches on your MacBookPro14,3 and for
such a careful report.  It's very good to see the same results on a
second machine, and the details you sent were useful.

On Thu, Oct 08, 2026 at 11:55:42AM -0700, Darrell Gum wrote:
> - Real S3 resumed on every attempt, about half a dozen cycles
>   including lid closes on battery. noirq resume is about 16 s, with
>   about 11 s of it in each upstream bridge.

That 16 s is the ACPICA problem you mentioned in the other thread, and I
see the same thing here.  One warning before you try that ACPICA change,
though: together with this version of the quirk it makes things worse
when something is plugged in: the controller with the device attached,
and sometimes the other one too, is lost on resume until the next
reboot.  Even with nothing plugged in, the ports came back in my tests
but the thunderbolt driver logged timeouts.  I've explained why in my
reply to Bjorn in this thread; v2 of the quirk will handle it.  Until
then, I'd suggest not combining the ACPICA change with this version of
the quirk.

> - On that cycle the empty side's xHCI logged "xhci_hcd 0000:07:00.0:
>   xHC error in resume, USBSTS 0x401, Reinit" and recovered.

I see the same message here on the side with nothing attached.  With
the quirk, that controller loses power during suspend, and the xHCI
driver notices on resume and reinitialises it, so as far as I can tell
it's expected.

I'll copy you on v2.

Thanks again,
Francisco
