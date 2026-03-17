Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A22390C82
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787764; cv=pass; b=gROIsBbwIS6SZHxdVWMosqMsQYQ2qxmrKoIVVSb+HlvwkM3lo+tyXp4x52y3z7gpf8BOb/1M77rQvys+Om5XVyFsAT0O+y4e7i9YRBkwzONMkEW0Z0KoCo17DUzMTLw2TbrkAWeD6luxDIgCCZn65enZgmPDte25bCo0fcLmboM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787764; c=relaxed/simple;
	bh=BFec/YvDGmpF/61lUMfG6zwWthGWb6f8TAqHQNOWG3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AK79tSoGnHt28huI8Vl+W+5YLKtQp4VFTVuDHpCyhiNLc7I+sPuQXRPhWL8Fnxyo/FIQ628OcCy+IKTsEKiyL9QRhVz7laE8crEJ+zWVHJ2Lz4K4ytCN8fjANXKPYlCdijmBnU5/wtWDwtOxPYBDGY/kJSBsH/rkovGtVd2pedQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXErUpXd; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXErUpXd"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7851e2cc4so118080a34.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 15:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773787762; cv=none;
        d=google.com; s=arc-20240605;
        b=j47YuBfypBwmbkbg/T2jZ0n998GA5RA+uLBjRmiLY3z9OT8LwQx6YeYjN/VvfXH1kt
         upmYnTdeb8DNZaqxqwDqLCI+2SVC57x0k0FiQrPH8qkQD8/cDdPWkwmg7IZ8eehXxJcW
         NAWD3xoPwGtsMwLC3eM2GCzMGLWasPN6WGVN8t8dAn5mVcvT9iGv6offc+6CVhu5i80X
         HqGh3Z+ZRzZZ8l8tAhcJAQ95yDPCB8A42Ao0gqnYRB86QWU5BkXawjHfsZ1a2LRdfrr+
         bwTCICTnfEWsRm+Xgp/YQnogGc9vyoCUIWNQVCFxjBY92kdD7bh46Nh8xahnf2lYDeQ1
         xwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BFec/YvDGmpF/61lUMfG6zwWthGWb6f8TAqHQNOWG3k=;
        fh=O5Mbt/mBQrIHjgux7Cs7hNXUuvAFRWVYNrIC1XiqmSQ=;
        b=UPddE0ZcE9+K2AgdTIfIaSDA+RBqbCV/HeTuo+uH/+IrmFzOS1BYE/bzoGYgmP2Hww
         WnnLf/KR2JUyKBmTO2UwNbYiU2CMpjt7ol65DC24xrVJRVHtbHl2YDKDCMXQYV40R3Qy
         8UD+gFOPpbk/aQD+IP3vzyw8I4pP+gKni48w3ZuUTimteTwLoD2uHbU9AvcTP8snc1NB
         ezU1P59a4HOoQhIPu4+jsUMM162zd6jTs5QJjnirVZq8XoBHXGTEzPa5a/7zsoVgmBvl
         A7Hfyg0KSLjPtwBmF5AeTk2l9bQN8qHnEI8nPQhCQ9/lM6K/6PR3QyA6HidT3gAkfq3y
         ph/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773787762; x=1774392562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFec/YvDGmpF/61lUMfG6zwWthGWb6f8TAqHQNOWG3k=;
        b=RXErUpXdke5L4yFe+QwmchpclIFpszg57ulqC1JM/s7KgHXSPpaE5Wlup/iTrAP8dj
         zWu7C1YCo3ktWgRMhFUYTs8c/ALZ53zDUyZllMN0aIS+Z98R7gvA4ZeMkiW2x9TTT5jE
         6Gkk8o0rIvR1HvD9xDIr3uLgRve1nBQoHSpZ1uXcqOUn487r3A29cR59Y/dvs1Ocuu3j
         youwiF6xjMFUcU0B7f8l1EhKuumTBK74xs4c9MS4JhC257ClUfRvjrHKKZ3es17OS927
         ReR8FC8NWkSyVOcdj2zTXDioBG+p0/DUfQN66itynkmW9f3W313Lk10sshtQ9vHKRdaV
         1fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773787762; x=1774392562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFec/YvDGmpF/61lUMfG6zwWthGWb6f8TAqHQNOWG3k=;
        b=hERf8Q8BhG+cMDiB4pxwUZiu6cDFkX00zYdVRmbOqltzqIpnegASbW1ZIPWrohC98+
         Rli23kH7n4/y1h0b5FXbegvNfO8qAZaMfvpu9sJTjPTcfJgzBVNxUK0fiUsC4CBWnHAW
         Ziavocm+4zJjVEMo30P+QVRaZAuwMQIzTpMVNvO8lmkep/Co5q/NGO5BMj9ZcmfOfZYv
         uOYHSg8z5Tcv2AbFMMiAeNQ9iO++ADm23fK86rfIgzp3TbyU7IA3c+gADoMzu/tO99u9
         8xYM93NKPiUFujIQ5aeAPaxvOP++NQAtrQ7IN1AhlzB0VrDrzWkec+w6QuDra3qViA3H
         IyHg==
X-Forwarded-Encrypted: i=1; AJvYcCWXzwdtM4I4AfM80rHHyy53B3v2W5L20rm6Gtof5AcEeBuR9OI/E/NQr4CcINZdNURX6ECb62fAnxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0Jb0GuNJgL4Hu+TMukZeBuDO4jbf97GIZzKX/U2oKltxeI6T
	En1b+6qxFm5PulnsJLly2OeQIHWK4WK3Jz04wYrZU3wLscr2NTPuhFqa3eCOW6eY/tcrhVhG02j
	F+9ridtQEZEj2nP+JwitF54gMpo0jkM0=
X-Gm-Gg: ATEYQzxyf2ydplwdnZVrI3x5j7RKTRWpG6mQAgaaxWpnfQMBFFM2JRHWViSkI4xxQwP
	GnCQwbaeCf6fkKqpLhe/Z3Zprc6r5vVq5KiXFlu7rV/4DcH5KpqNGM4j0Y89Kp9JFeIz+oGincc
	Gy9u6Z3SW8DbI1ZKZwMBPfmEC0GOuSxnXGjuPDI7qOHFTiej0Joj+4Ajrme4bQDxh5JDHiNif2w
	EqMNoLTsTZHUoXI12PNLrd95BtI38ZA1ZGwrQHD8VrkCeoP8TOzbRzKEeT2ZTSYWxFe1aYFanGc
	E5MML/Jfmqppl02j0uY=
X-Received: by 2002:a05:6830:82e7:b0:7d7:382f:f006 with SMTP id
 46e09a7af769-7d7ca5a627emr722497a34.10.1773787761910; Tue, 17 Mar 2026
 15:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223023645.344137-2-majedalkhaleefah@gmail.com> <20260224180036.361502-2-majedalkhaleefah@gmail.com>
In-Reply-To: <20260224180036.361502-2-majedalkhaleefah@gmail.com>
From: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
Date: Tue, 17 Mar 2026 22:49:11 +0000
X-Gm-Features: AaiRm515a4iURi3bNvWQVpYDx-Nl5W7M1Tmg98Ix0bcgLY5xXgp7n3KZQb72GGo
Message-ID: <CACeAfzuhqjusEdY0MDjd4uxPT8g8Lc=UQBcHgHx7oO-kZuG4MA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: hotplug: Change return type of
 pci_hp_add_bridge() to void
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Scott Murray <scott@spiteful.org>
Content-Type: text/plain; charset="UTF-8"

Hello. Just wanted to ping this v2 patch. Please let me know if
there's anything I should do. Thanks!

On Tue, 24 Feb 2026 at 18:01, Majed Alkhaleefah
<majedalkhaleefah@gmail.com> wrote:
>
> The function pci_hp_add_bridge() currently returns an int error code.
> However, none of its callers actually check or store the return value,
> neither do they need to take any special action in the event of a
> failure.
>
> The execution path of pci_hp_add_bridge() already contains relevant
> error logging. Therefore, adding additional logging/error checking is
> redundant.
>
> Make pci_hp_add_bridge() a void function.
>
> Compile-tested only.
>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Majed Alkhaleefah <majedalkhaleefah@gmail.com>
