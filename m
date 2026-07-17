Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AA3E51FE
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278792; cv=none; b=Zp/Yo+1pvXy6Eyz9HVYNhStWwPK+Uw2dIqJqbxngd5NSKcvFhK7JDIjBe9g/pCcFcCQWEObK8x6a/5gxgQeA0TKUBvHid5rQ5KSZ3foQ9AEtGL+4kkjllgzTkJgQ6eAf6vs1ERHEqE875mk5Ph7tBndnmE7QSegooGRnItqDr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278792; c=relaxed/simple;
	bh=MmlsQpPS9+I6DviHazvbYMQJrGhDRNhzqMPYAL9+l/0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxSuzAJZSW6gIgEl4qA1TV/XjG08xXMsYxAR0dW1ACQlZG8NjA+gpBiPTx6HSwcBhqDvqRTwXO0REaNY25ojcy+8nS1jF/kp3ztef1/wkg2kQvF2Vnp58ZRQHRX8fKDpln0QBokwEW+W3cg+ZqVdHIiWQzrBLZ9ixed9xFckH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTzBR0PH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTzBR0PH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847791F00A3D
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784278789;
	bh=MmlsQpPS9+I6DviHazvbYMQJrGhDRNhzqMPYAL9+l/0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=aTzBR0PHVrD+DcQSVg5ZY5YlIDjfMRGSCpYbNLUYG/tu4EeUwttW0Wn93oFwU/DI3
	 qa31qR+tXhSR84T9Hzud0RNfECA5kyXMKtW36ms9IZKvV5jsQC0EXx//pqMBaVbM2I
	 dfqIccN70yY8Mj2PELjQot1KGnqXSi6Xme1unOe4/QGXXzuNPWmIlcWRo2Z1eRNPLu
	 0SN3aLqd/gFuvqsUsx0xSaso86v3Yo2s+tDlapby4Tm1+t86fskHU7Wm6EnIUxB0o5
	 w/HrBysrn1SM72TboiQDS66QlYlfnWADQ6nhD+rEcnMls6ZdtOzIl+d7Jk8Rwxq7jz
	 9uH1YFXNP0Prg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c86945164so65286281fa.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 01:59:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoaaK0cKvGQt5EiR5r8WfS70tCFejgJAuoidz1OUSi5fV00W66mhkG2QLjV8XYyfu8WC72ROwhchyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMQJOFzRgohvr0bdzoqtDTJGrKKSq2/JMIccdx9qGVoDlTeS7
	daNk+J2xH41fx762YxCA5lWq3PEMl0jBg4g5uFvmnB6Y8HDKrEZ4qKdFURaCVD5dNR9C3KpX2+V
	ZlhNEywO/thH+t3m5d7alxj2Nw9HnIM0c+myp8OBOeg==
X-Received: by 2002:a05:6512:4045:20b0:5b1:5ab1:b6d2 with SMTP id
 2adb3069b0e04-5b28f87a491mr277173e87.22.1784278788262; Fri, 17 Jul 2026
 01:59:48 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 01:59:46 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 01:59:46 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716132532.1565340-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132532.1565340-1-johan@kernel.org>
Date: Fri, 17 Jul 2026 01:59:46 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeU9qkFBgD5OSeDb5iJRs3o+wtBpD=hu0Sorvf7z1nhZg@mail.gmail.com>
X-Gm-Features: AUfX_mxEQsjFtr7U1SicwG6sErdEVyjr0gKYLtVFMaUxSopVYwWbDzPyBUM1Ks4
Message-ID: <CAMRc=MeU9qkFBgD5OSeDb5iJRs3o+wtBpD=hu0Sorvf7z1nhZg@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 15:25:32 +0200, Johan Hovold <johan@kernel.org> said:
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
>
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
