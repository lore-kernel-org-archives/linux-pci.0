Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AC3254A8
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509216; cv=pass; b=evnsQ7fwc34AaLScWJa+7NKUvWhB0ahc1EExBogZ2NBrP1+Gc1cTk5Q726cmdqEwJdgn9gKWS1fjFHcXZ0VyUqbc0bE1r918pTMat6E48ko2naGJlqE6YA/LbPDzhYkegey5OU2P/XVM0RArjXvVdhU6nzpHgBThpM+bAESBlTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509216; c=relaxed/simple;
	bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWQrD6+UaMhfwswSngccTCr2VWTtTyHRzDMNHpycL0BDlo56hMKcyJLbDpHOgPPa/d6bI/fyz3FngB+Fuul8pCCX6sIjmBHNdK+Gdrpt6T6UCijBcMBhgXfKQdzUBmW0H30K+ANFv+gnJ2creWG4CUoUbcyzPR3Cx/QGjqc/PQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rB1SMZCG; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB1SMZCG"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66aed966c7eso654404a12.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 00:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774509213; cv=none;
        d=google.com; s=arc-20240605;
        b=eRkhMMgxvdmCUzINMFIB3VwP8P/iD8c7A28Q0u1ZOu77qizNtMlaEMUlEtu+j3AkBe
         NzMPQ2/OIgLmJj7HgJQTLQjrntY/hyz0EvBSzIclDnO3y3w8KXf4SAJdoAYfeXWKkVhr
         H/dtHYHGM3mcYSLWGTEs+YiL2HVwf5HH1pbS232NWbrpwdtyN4f4MgaDeFQQqvqCUsl7
         mSRKDbQoWdGSOC4GJWX18Dx0qx0tVtzRTSnDdHemOYaxeMEvrgx758pNaTuKYitqBsAt
         fKQ09+1OfaGFZf8BVYvywicYCqX3OpE6+NIMr6l5dDL74JFpfuLwzm0lBvrC3WUWWG87
         J+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
        fh=q8qiH7YeCfRxJ4XEJlR/QuTr0uUAXSPR5p48pPppKYo=;
        b=aktVXQn4GynU4N0dO/P/j1KElqK9ka6CzsNFYKKG/Idq2nIRij/CSJkvAXHScXIg5L
         6On6XW6Xdl8CUpRSpJpHI2xq09HYqPetQQz5uBTt7l1IIRaoMWGlfCs1asTnlrHLUbeh
         y9fcgSpCmKQnKt7oIWVkUZcylP/NhKKGXA7+UwfUvCYAU3kCPuRx0r8FQtclWJc3iZiN
         l4l5n2qqHl5Wf8StJMult4vdUWci0MYdy0bG2yqnVZXmu1unsouw3hRvMqUOr46Rt5hl
         raYPcBa+Szurza6F90H2o15kdtydyHYh/sI6NnugtTJcA9WhiTEFupNKWeRJKzEqzcB8
         nU1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774509213; x=1775114013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
        b=rB1SMZCGITq1tVKsatq/yryA3vGnuekSTZBTQuM4ftYlJk58yRKxZxMpEt4wtz63ui
         jEdk+hSwekxZB+5Z2Gjv2rFDNwxo2OekHJP17yrSm1fhXIbT1WaXiY434P1bbutwlGuE
         LNyX4GE07fsIrZjeA6mU8Cq48ckYAQ4UEKhRNIG87xSS4yXpXZzexrBScl+unBs1Q06w
         vI+Qfu7TQt2WuttLPbRVfYpwguxouRVs9BY6LgkJUw1kHcNuuI5lKXMMZ6kMt1VIE69N
         IsaSbIQNCT1HNI0kAaXWMDWXuk8DRPvYd46UFLzjINMdqru480X2Ini0WlrI49ENByLQ
         i4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774509213; x=1775114013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
        b=gNpxPYyqbUNW5M/7U+0oRBmy1wFpcN7ZEaOvlrWYt1XPNxURKBLi5WNaO/+corMw9n
         OQB2j0pQuoPXlPQvZw3oSm2kbbfeT6oC3i3LHKTL7tgdYaznPlPTvqzkMCpyHHUHGPyL
         dQGsb8x/RaPNCNm4HpuT2EW8oEoBtoHUbgnzV88JDW3cZR8b3IMHBr0ThcDAw4BCsxoV
         6GZpcczGHUl6JoZmWR2fSiqZKc5Q31RUl18edAmkLgTLKdE0yd/qM5FFlOg3y8vC8aiu
         GVnhx5Er69xF3A36+riFCJliEFuUUF5+7h/HjoYsZICbcJ59w/QR3UzSIWJmbXNWyBCR
         r1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW+yHIdOrNYKYSGmlyo8hYsosh9GUOf5TiefeJheRUpg4ybSBvFNqFv1qTo1D3Qdd27gfu13jOHxrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrq6XsNSzXP4eAj/pHu4t1Nv+Eqf4krbl4qNo2XGfJRavTj55
	hpjb+O/UquFg3YwNRfnyfMvucgrxdTwL9wKlmUq8EP9monim/YeQ82V0x9017TqMWRRxninKSYK
	43TI23roryL1MXGQbEVfOch1a/DX2T2g=
X-Gm-Gg: ATEYQzyY945WzwXkljHXSnkRgwYNEBzpjwAouw35xQpxZOZvNoIIDLhpEcd79jMKq12
	5d6yOEazgYHcz+zv55Mvog1fUBwC1jVOD+JsKA2za1mSOwWcANPrT65HuRoJT9CcCPc5lO09z7m
	x4JSvW577AjlS/x4BIMWOUBQ0wHak4qJ0IIUEBhSCIrU/xrdc0NOPazO2FaC5+iT9U2C0nV0I66
	wr3P6ymQYPMIek/55GkDaxyNhiutXJDGksaARilEb2xjQIgGfUFMRVi+ms9Z84lh0Ccj1LGm7dV
	QvJnY8+yHpF2DRZg
X-Received: by 2002:a17:907:198c:b0:b94:1d92:7eb with SMTP id
 a640c23a62f3a-b9a3f1919eemr458328466b.18.1774509212875; Thu, 26 Mar 2026
 00:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com> <1774403912-210670-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774403912-210670-2-git-send-email-shawn.lin@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Mar 2026 12:43:15 +0530
X-Gm-Features: AQROBzDzOlAx1sUd2S5bjE5iJHmFf32DolWrjZ8MKJ0g213qpmInERjK8VvyQ5w
Message-ID: <CANAwSgQMy2q18Pkg7caunY2L0MwuFjugX6T4A4egSk38x3+FCQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hi Shawn,

On Wed, 25 Mar 2026 at 07:28, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Some platforms may provide LTSSM trace functionality, recording historical
> LTSSM state transition information. This is very useful for debugging, such
> as when certain devices cannot be recognized or link broken during test.
> Implement the pci controller tracepoint for recording LTSSM and rate.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
