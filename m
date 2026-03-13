Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301F29D29F
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381327; cv=pass; b=KOCcCNngWxq8frx1pTzTHFHcGzJUdDbCNTcgK79QJQZq222KbZrdBLU35uJM+jWhcB3oZJiIV6VrZ5lR+HDwicSCmEz4sGNEWZ84Ibf5ptTrS/SFH7ZDbIm2AuJpjADXNkNw8zi7gT3xTIofP9SM/23pqiUQSww0/OLOq9xpXeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381327; c=relaxed/simple;
	bh=zd0DFMoOUdpXYUPoqVp5qu2gOoi6hEJLHj0/NV4HW50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SemHVtjeR7KZJ+HCGhY1jor7n4YabMp25csdqA6dXPdFwsSmfaxu91Ehvy8LKtejmF4l+UtNJjuNSfU3M20pPSD2pMXiOLhzHPSZtKq0ysAG9n7o8eKPeq8W/WRuInp1qDhTqYmnbRxbwiNlJgsV/kMdZC44sfamS9L27WeEUJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh3jQZK/; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh3jQZK/"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be084d8166so132118eec.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 22:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773381325; cv=none;
        d=google.com; s=arc-20240605;
        b=MKBsXro++tiW1yRtX7JwPMt70RKSDrLcJKNbPU7ZdNrFQA9h7/r77xE0fLmRxeGeRq
         4QFzrvJjRThFa9884RDAWkeNvteC8H/00LKU7s3B79JuF1nvpMFMvl6X5hZvKohmfhhY
         HP4pgbzjxff6UhCJmYqmmwMkb9BE9k9k45xw4KM3+CnehHoBIbu/YbtsG1gkDMnwpNtW
         kKUUtv2ar2C2qZFO5a73dQY2YHbfgGLpgusr5R4WMIJe5erE7lowJNigfksMcWQsj/zh
         AodLSW1HtyuRqQu9Mf2riyf/bMC7oLjff+wzAal3RGmhPEH4K8DAublqAqLLCz4kttuh
         5iqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d3dtALaPCJdqZRMlZZXkb+T02WwonQG67w0QNxrtLtA=;
        fh=Z3BogXCbRrdZKpQFU5EA6G1nE6zHziOmyZG0q98kRmI=;
        b=HdeZiQxNC9ZEkCb/qm97MufzmOtoGxwM2gBProfBJtAH2/2d3jbaclvm7Pn7IUf3Vg
         KSxx3nqaqoCI77MO81d3Ng6+NQ9z8zd+GKm+86Q7ec+8gYQpEZ0VEZVy3fv8spzv2U+I
         0IHZMFwvJHCXJx19LjQsnXoxtqlJ8Yemb8Ad0UcoZsifkyes55yRkq59IsBEyzEa7spY
         i6jhGVM14LSaQpXK6dhek/o3nNr4qGTe6fLZsZrngbXtSFTiNrYrxv+ivOsw9fCcZB/V
         dDSxCT18744A/PyW9HwGmX3N4Wf8/qVYQNnIrlnIEYkgnxG8u9Ys6X4s1RrH31exxia3
         qGcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773381325; x=1773986125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3dtALaPCJdqZRMlZZXkb+T02WwonQG67w0QNxrtLtA=;
        b=Rh3jQZK/obQr8YER4y/qTMe3TJUp6ucaI7awTxi5K1viEofft3w3OUOKUZkvTXZVs0
         SzWDvPs2u3gie/J/BrzBZPJF0BpcUH02ai2OiRR6u5A0JlGv0xzlKSpGg6r8ONxUBWun
         DabGLqMqcPSw4iOSFefSfM4cerByCeIG0Hi1PNpOS6esSgq9g/ysGiqLs/KVj0JLFKML
         GnfoMuueK+lDEdTGniJzx7nKKggYYYJwV5KD1n8tu8qpqFQImxn0pHjrE/I5cEtxCHv5
         hLa9Mt2F1lBeV/gq2c27xCRwcI3+OE3otcdeYn4lpPePAl1vLg2b6qVRwAmbttqEB5e9
         Ev5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381325; x=1773986125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3dtALaPCJdqZRMlZZXkb+T02WwonQG67w0QNxrtLtA=;
        b=DdcKHKw4d7RuG8nX8BhFyG8BKaX9lvuB+YJHqpMUJsp3I3fjPgQOZC+MEp+ugDi0jq
         PSow006K1t9bYrcoTs35bP1Y0Pl/Nvr+yhbWNuNeR5dYV6GUZD0TPrmfa9OYDeANhVus
         YZDwRFv9awLdjnO1A3h56NisGOcqv2QzgD74eK4uNfDTG2RW1xVd3JTNNsfAbSXBZr/M
         ZsJRyxo9jZ2oDRKE7yyqQRaYjUJaRf7GOee7TwA1tM3QXtSyi2DZkZOJBOZG9+MiC8sV
         JlYdwbG9Z6spyX1hduHcNNEGpluup4SDYtWtrJezCPEFgfCThiVUhhos54W2bixYyPB6
         1e5w==
X-Forwarded-Encrypted: i=1; AJvYcCWxGoNjhz1pzijd5yGaBFgxW2oytfkw3YGZBSU7AqAeX4+e+L/5jTFhWff/Qwo1zfUVmtkuo9If7y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93ceyopIAXJmM22ULvX0aN84c2rNhOlJaQEajyKfZY4OD6wpJ
	SpQVXx6H0DcaMIkn44RHJ32olYQtmy6eJojil390oTLR/65+6pCkr5GOODgA2nLhFYHwK4al5fG
	cCOhTqSs2H0ISQvQc9r6gNvEO2nzpKY8=
X-Gm-Gg: ATEYQzzWszqAXkRQgaFoke4S5XO1XIGFrNIxmezfNGPOMNOh5oeOQkTUjbw2aLStgiy
	oeu7Q05KEy791OUH2HItNNHl3+KNt615B7aoUj/mNYyOlFk1vkPkcEo5SIrRABmxBN55grMlMDP
	ajJKgWZHMnDWjo1X9G2UmS9BWY2foIh9pzOKIbl2IJ8bZQYfRwxFXy1KArgNp5VROzsdinv4/Wj
	UgLpC4QnGWRVV+ISOCLCsu5uQPAzPa7+daoeJJ7yVCHjoqMEejDsMfMY+HlCmg0syBKXvU5txPD
	T+tqRBhSaJFaa9q7ol5miZ4ti6dQT+/4cDutnSD4ycCzen56eZhL1EDMTgOFVg9LcmYyhA5d0Ip
	hMAUUh3wGCcwjrxdlPDR7b+c=
X-Received: by 2002:a05:7300:fb88:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2bea55f6aa0mr586120eec.5.1773381325426; Thu, 12 Mar 2026
 22:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-13-alistair.francis@wdc.com> <20260303113642.00005774@huawei.com>
 <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com> <CANiq72npg6Cp8EfvP4H_PKhSaenq=hhOvV2VyMesc+rR3hB0DQ@mail.gmail.com>
In-Reply-To: <CANiq72npg6Cp8EfvP4H_PKhSaenq=hhOvV2VyMesc+rR3hB0DQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Mar 2026 06:55:12 +0100
X-Gm-Features: AaiRm52a5-VzSErmrex9Pp1KfSZdHDvErZcjdkaddKkUtEe4EM-b4sQJQOaYYa8
Message-ID: <CANiq72=eHZSUraTVvysu-24sUqUSakWwQ3Z0xcYTLHEV1hKpRw@mail.gmail.com>
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
To: Alistair Francis <alistair23@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 6:53=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> We have `size_of`, `align_of` and so on in the prelude, so you can use
> those directly:
>
>   https://rust.docs.kernel.org/kernel/prelude/index.html

Sorry, I cut the quotes too much -- this was supposed to reply to the
`total_expected_size` part of the conversation.

Cheers,
Miguel
