Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D138423D
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641566; cv=none; b=CQXfmUffcZizZZmp1CLMdAPM1eCBm5k4TRA7Qo83HQvjAKLb392XY+3J3roHu5t4uunC3T0ptDbn/Dpgcrytg4JgSkafUN0ze15S9vwloSNYs8CyDLXvttRth/nGFnXcv2kN2RzEY7JaB7ESi63MIJ4tMQmfDX8uDfskys6AIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641566; c=relaxed/simple;
	bh=N2ju37nvOA57E81asAY1dq8AEH+5UMeli1v/PZAnpEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shzDaCVSCyofs+MZw1ugL9JQAew4vkYLcQgHXcQF0zELb0CNp2hXyjD2D5jzRHoONniHZHvCncJH936VB0iivKe+WZLAc2I1VFNxc1AEXbUzAK4DENpzaJJgCQLSXOcRnvWmO/4i5x0/ZA6JXRM3dAIaC2++7c80SM7fr6hlRag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnCI+3qM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnCI+3qM"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so7389398a12.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787641563; x=1788246363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGat6d7NI0sFxkt98o/AYnXtRvGzfj8FLrXZFFK1ZZk=;
        b=qnCI+3qMhAIGv1ScZnb3g3yGpsbH1l4Dc4ZlHStlK/vw0RVhqlw8MX0erycdKduuiH
         OmK0LNuJVvqEa8D8F0jW9HafYp6XiiBqSJvIkylSdf7mM8x+dTrZt3s3LPEDIpykGupJ
         2LmK3gTgRzjfMRGRQ8EnrXOkwTd+vQM4rN+r/4bIiwh9ovBuqm8NHun78DJwknn0Msfg
         +CJjX3/tiYPeIOX7C7FgAohRvUOCm08XaN5ejhLFQ8jjHe3i5JvnIpIxaXLp3HcRI1mD
         h+CUdccGyO1+pbmijrz9l02HFKJscCJ9bqrdq3KyYjSidncD/rdLNK+wY2dMdz4G8iRn
         e5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787641563; x=1788246363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGat6d7NI0sFxkt98o/AYnXtRvGzfj8FLrXZFFK1ZZk=;
        b=gdf1PWDd2ev5lav23MqLDch96vkFcQMBEbFtEWlXGxNZOLZhnM5P0FtTqGRmhe3Qw3
         ClcrwSATSP+GZ4KTF0swAZMpls9pqw6f7yZnlUHzWQ+CHjyYMhnuFyJy6ML1MQ0ZR5sx
         SsjB9CzYDn0H5xnofho6CyBI3TlU+IKt2sptYKnSYlRsdGJkK2Y/HH2bR/1VaxujjN/z
         bRFBicvF6SUC0iXTDZLDYt6/g+G4PqUT0TEcGbKxQ2Ux4ZJSDuWSY7WMA+U4rM2FMc4C
         9tgrKQu3ERoLfEdW1txfGIfqmpO69WrqdhQdcRuvI1QapmZfMEkWnYM6hJwN9iFLjbxE
         Srcw==
X-Gm-Message-State: AFuF++lDY4hiKWhMvuDA3kZIuZe0EKd56pih3KiQ/WfrwKYXJN5tmg2X
	aD/nJ7pKTqdwQ6HcPH226asSe76ufBRv6P025Pm+iPvIiKHmXF3UwzOB8nPYh/eg
X-Gm-Gg: AR+sD12cbvm7YH8fw2muB5Wj3Ut5MwJntnxgYKXXmdwZVSh0UprfwFqvc6UI81e/m+F
	K25MypFZx47jAdtHGyCg75Km58+4sDuxHMtYUx33fYNurRG+G1FDZc3N/reS4axaTlf47IqU70H
	k97GpeqM0wUwJ18g3tqhgLwYUU35sOWBk4v/2jZ9iDOSKQDXY+58gCvloaYXuTVqqhy1TVIKE5Q
	a0PvophsRMurKMMWLX6NMcLl/3nzK4CO2VqJYdd/+xMcZ2NGpQ9fXsNJzmEptidJQh+7t/HOHGb
	yv/r3cAAdOXGZ1YviNiEEaOQFmxRX2k7GGR7wK9dbnhCj4UwnL9aou9zKgTx9n7t+aKI3/bvqff
	Dl+3f/EqL3XI7/qb5oZOtF8K6jdHnUH/uHSpmbUHsQq5ovRSLiE3wl7GROhOdhYYAjmOljU4vPo
	8MTfVtmFoRxQZH+8cOFKz3hSl4M2FaaIkvtJ0rZNoaMLNg0cRF0YZYOJVIm8QguYlrT3/6coQA7
	t7SGKBVKbLLhTJil9GZ4CHtbFPpSo49WWWpqrjrslsy+JmKTu42uKrUiAgWFU6W2ciL3yC4d4P4
	mu2nPkdcsoVtegf3Wjw=
X-Received: by 2002:a05:6402:3888:b0:6a0:927e:39e2 with SMTP id 4fb4d7f45d1cf-6a42f1b7471mr38702922a12.5.1787641562945;
        Tue, 25 Aug 2026 00:06:02 -0700 (PDT)
Received: from corecachy.localdomain (p200300eca748c8fc021d81db54571dff.dip0.t-ipconnect.de. [2003:ec:a748:c8fc:21d:81db:5457:1dff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1cdbe9sm12235854a12.24.2026.08.25.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 00:06:02 -0700 (PDT)
From: Andreas Wild <andiwild@gmail.com>
To: Thorsten Leemhuis <linux@leemhuis.info>,
	Aoxtj <aoxiangtianji@axtjblog.cc>
Cc: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no link
Date: Tue, 25 Aug 2026 09:05:22 +0200
Message-ID: <20260825070527.8481-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <7742d556-e878-4893-8b6d-d6039ddba544@leemhuis.info>
References: <20260801201244.4421-1-andiwild@gmail.com> <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc> <20260808063103.10940-1-andiwild@gmail.com> <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc> <20260811064233.11315-1-andiwild@gmail.com> <7742d556-e878-4893-8b6d-d6039ddba544@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 24 Aug 2026, Thorsten Leemhuis wrote:

> Side note: what's the status of all this? From the outside things looks
> stalled, but maybe there was progress and I just missed it.

Nothing has moved, so you have not missed anything.

> Are we waiting for a reply from Aoxtj before moving on with the fix at
> the start of the thread? And whatever the answer is: would it make sense
> to move on with that independently to get the other regression (boot
> time delay) resolved?

Not on my side.  Aoxtj tested v3 early on and it does not help them, which
is expected: their link is up at 2.5GT/s and v3 only skips ports with no
link at all.  The two are separate failure modes needing separate fixes,
so I see no reason to hold v3 back.

Best regards,
Andreas
