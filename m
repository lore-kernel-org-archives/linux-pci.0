Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FA1FF7C5
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043694; cv=pass; b=jvCpIVWUuYxQmYFCc/RSi9VvCoWwfVkZMFSHWcSv4uXwWhw7F6cCGoNgmcuYZbSHLAXSrtoDHp99CfxHdve6uWrmStxZxeERuOhLVca41kwThBkEMtrgtYdMtkdaK516KV2WJlRe4wWaeEZTPbXDPZCWyjr/3BMarMW7IgFZFds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043694; c=relaxed/simple;
	bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuHstvK0O7BV4eV4+IimH5rqPiLFsNMv8BTs30yAnncWqLiw3w6Q8QzyOtAvk3YE/g1fimdgU4E5zGZLf+Fdbc3/fiyTyhCaDmIqNtJm/aFObsGsoT3iK/d4Dd9JKpEciv6lR7RZR0gnyHDPuvLbhGOwcYhXEFKiQmtahQBhWZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPuxM6S9; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPuxM6S9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bc76e15261so530960e87.2
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 22:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792043691; cv=none;
        d=google.com; s=arc-20260327;
        b=mVRWdr7Xypopc5bppIFHohH9sBfTTMDExBOX4WiLcxsItxCTzL4/cpw0WcA3OENAgu
         WCo8tgp0GmYWSArGQmdV+KUVsqh4fxOq3ISGjGyMRMG4ZIZ1KSP2vjPWkNRWtmviHb6p
         /xrPh2Rpz4qqCnSR3n772EGTJzHSfXqJywEP3emMgl8RXlJB5V5itGIpW3YH6d8DhlsK
         xMp57NIbvvHTPTpoLiaLS/w6BB6oGcvCTDI2ak3IfmpN0DwpzLox4/VexEJdnlS7hCGk
         YLAbOp5HQXC/eAhL0LtQw818DfSSHObId0QjlqGd2eqfkHThxaPhHsOkrJfbSmZhCcUp
         GAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
        fh=ufa2KbuJkQ+Dy8kRkjgRmLlyJeqzpY8zOd6+PyO6IuM=;
        b=eoh0ti9TBR7JdtGXtjnuY7ToTHGffdBPn07zoaNbY65g2SqM/7EeuRmUZPGbX+m3j7
         wyzqY/bJXuQGy2cloe+vvkKQHYf7IIgq9ylVm0NTueBu6IbGi37IVOlCQuvoJcWUD3d8
         jNIjvg3olWtzlTKyRb9gJ0znKCq4LIWmP7UmPAQzsbuQWiOwNKRGNckkab//L8ENVLF3
         iYzGpyZWAYufRdlbCcGDhw03qu+RFdMFjEFpWaFVkpB5WKKVYAfCiOY1mxtZs75I7YjR
         Canu4puWIPlKDWYy7m2KBixp7UYZEIikCgn8Wm/CkoXiX2cCrAWKpM1hwH1DZ8WkDINM
         r0AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043691; x=1792648491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
        b=FPuxM6S9p2v8n3MuLy5LbCmvh3M/e4BYOVO3lYHGE7sDQYqB4AJV5d775id9IxWoQ7
         2iPd08e1ZlcOExL+wk34LR1qgzwJlqHIh2bY9i4dDwN9WxQ5n1c1ODb4l2W9et1Nnvq5
         67tw/nmX9GG/4VaH08gNR6JlZER1uQaBCKbFvYRxen/4DQhvMUNZSg3zZbT89zUJTomB
         aFcc56JH6a1xK6eGkBViLmdDd4Qa9Ak3aEAfnnGHGY/vYD4kAInzFFnWMx2s+/O3JaI0
         Iyx+Vf5+WH7zZ2YAmf1rlWuKHrrXgl+GZAkFZbFIEAWT941+VYn0PmJxF+D2bLjNYtbK
         Qb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043691; x=1792648491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
        b=hoQjtaxODBKc1QhqjgwyYyTYkXUwmFmfnEd9K9StEEast6c+br0Vl1FCtYTDJf7mPo
         4qOw1AfBMvHG4L7lIcI9r0cDpwNh+iY+/jZvI+9uZQq+5Wl4TvakDfpfj/n0J7tugzZ3
         /QRaEXy5GqutM7ubQIWhzvwp048OS1TzkustemIsNWQtUAIGjj29QSTl6M2r/3fuhZha
         87FRfNy6nubeYaxXpL5ERT0yu4xgBuaJmU8AJMP6Bx9OPSOMEdyT5vcqNLZVqorKYMcq
         idGyElgejnV4Wtahuf6fNz0yKgqNDPVDFHRkhod8bb0L5vzHV+rp0NYxnywl4RZiK+/Z
         ck5A==
X-Forwarded-Encrypted: i=1; AKwUvBx0oaVMKTxjvvIH8mOkTDbq1HBwXZvwxPYbOH7+8xPUEigO+vflzlJj2uuh89n4o2dEItvIK1XkQl8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwU31aXGqew8XjtbCAZ67EkAF0pNWz4CnJgMi/R1LYVo4Bwi6c
	jyiqjHn+gpAITGCeaZ6kGPlWQRdEMlp4oyQlG7OjEgsg24nuYcuiJyU92KN34a9IhuyzPQPglHi
	qAu+uPjF7mVOD982uOorNDyJgqXq2K/4=
X-Gm-Gg: AYBFou17gN3Wyc2ICz2a6QCtfnJOGWDThOoecALSq9tBLVDuCrDx+s+llywTc+d6qHU
	N7L5KFunes9CxLdmlHTjeJ0B5FcRu1x2QCnxVU4akqrhC5INmsfj4GJdbD6ElesIqbaRulOZfNR
	6Yhg57lok04vaZ92zQ4TGl5O1yjVxEhjhjoZR1POLQGsPVfkG3Stp56X2D416JFNGQMNIE4/iMu
	wGWD5sbTxcc2GID66Huq/USuC9IhBYofkTYbyV/Pc0jqAHVv7ip/+OUxMFAlrofPGZCS2k6Ntth
	V3GO406AnhnuamH8NzCHhMNYmmqs5WFQjHITDPjLyMaW/ipAb+/mJuXOMNVzbISIvWHFxnF0WRX
	LyVHA5ALsaKE317arB9IN6arP+CT5LsIPziXYJt2QVn52RMcNDiszrVcYUmPvuJIiuye5JCGAMw
	8FHeA15h4invDM7/ypVAXd8vh0nkLCXLbC/g+WEObQpme2drDXRKU=
X-Received: by 2002:a05:6512:39c6:b0:5be:3f94:ab0c with SMTP id
 2adb3069b0e04-5be3f94ab5cmr192058e87.5.1792043691116; Wed, 14 Oct 2026
 22:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <as_r8n7p_wdbChuQ@google.com> <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
In-Reply-To: <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Oct 2026 07:54:34 +0200
X-Gm-Features: AclHuK9vg-7Cq6bGY2mpKNcgjuHSAWaQMnCCX0Z82MCYQeI0nb3RkBYX20rXqpU
Message-ID: <CANiq72kP=BpWL5-X3iGARu6ekW52Lt0uCxd+efa+ME02mUbSJg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alistair Francis <alistair23@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, bhelgaas@google.com, alistair@alistair23.me, 
	djbw@kernel.org, linux-pci@vger.kernel.org, wilfred.mallawa@wdc.com, 
	a.hindborg@kernel.org, gregkh@linuxfoundation.org, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, gary@garyguo.net, ojeda@kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:23=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> I was trying to avoid adding crypto and X.509 bindings in this series,
> as that's a few more subsystems this ends up touching. We need to add
> PQC as well, so crypto bindings are next on the todo list once this is
> merged.
>
> Is this going to stall on adding crypto bindings?

The general rule is to add safe abstractions first, and their
dependencies (i.e. other safe abstractions), then finally the users.
That is, adding code that calls C bindings directly without a proper
abstraction is generally not allowed.

Exceptions can be made, of course, but they need to be justified, i.e.
there are cases where the kernel may really need some code to land,
but one needs to argue why -- it is definitely not the default.

Cheers,
Miguel
