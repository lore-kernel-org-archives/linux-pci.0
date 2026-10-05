Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3704CA789
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215156; cv=none; b=EW6Dmk6YjbAmUZ87kToEGdck1e7X8/Yc9M/Ykqn+kWq8TnMCXSrFfGW6RUCMF1/vq0dC/ojR9J5ooHj2rb5v4g1EZQIW0hreFCmTNVDURERxXOf9EKGn8hQDZgL5FXSn/L3uYr8isiM6Ay31Bo7e40LIqLsgowGpCuTKxLqewdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215156; c=relaxed/simple;
	bh=0K19+1F4UsN0OHRXHQqyJ7lXT9gNpPboBHoZVKiqBBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IM8WHDvt+PO06tcUmVy+FqV0peRs5ViYalhz6wTzBiwjVzxEvTW2+2llFBY8NP0L1p5FUCfY04joWUEDsUG6pA7yjGI0aRLsdIHSWQDS6owtEgOKaXyfmYqX0wO4yf8E6JElxUeqnEW5jbSLH/0i9vpDIIlDGaJf5zGfdmRzvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5u1ZLWg; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5u1ZLWg"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc44d708055so2693450a12.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215153; x=1791819953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0K19+1F4UsN0OHRXHQqyJ7lXT9gNpPboBHoZVKiqBBo=;
        b=a5u1ZLWgAFKTtYDh0dz4Ft2gEvSqRjsJ93iMqnBmtkjZUXvQ+IHXYiUJuGjpzNCS8Y
         SxbS25FQHZrT4B1zQ7nb4F4m63ZQkgG0ADWFwWTuqsn93mQm2SqJ27I3ZaV6L6x3Nh1V
         +LXa+7i09lZqrUPYNUOGSpEI6puua8YMxJ6bqZ7dGS5VuKjrx4ClTIl75nol8mKWYshi
         V94x+K+Tywu0i/QP6TZlo9x35qTVQvOKLBdPBbXkdOGPsKAh1635ZfGedDYfe75qiTh1
         qz3THQQC/Etm9X4NcHbigeHIExJQarYuH+prAOcNVW4FcFsZ8niAIGhITVJEWyZc8GDo
         SgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215153; x=1791819953;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0K19+1F4UsN0OHRXHQqyJ7lXT9gNpPboBHoZVKiqBBo=;
        b=V/jX661I4snXYNgTSWvFjpat8xkqOr4vYzCEgVz2a9S+huHP6xTSzGwtgrWCyQagxB
         7CKAEbGy417i8Ye6i3U7yjYuVDi+V1lEwWDOO6Q0b/BS9kREZpvdGACmv+LYBuzd5Fei
         fQeSIZKnGUgQ4dNd6otWOICbyqcvOPb1MGfpGuvRg28iIj1ALa5VZWJA1YkJyl2D3RNl
         CIS0F6UOHqj/bIZPGROf4m5+xLIov6xwhOOS2X4j3KcY8nhQq0U5D0GZBlXVGRH+giO4
         4+GlazHXH5GgvpgrGy9ww2EogMJtPLnAiP4jJLdLOeazdJn9ECX2vDa3C+eZIhP0owhJ
         3SqQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0dZvy2g5A61YBgIeOaM6zg3cO1bbBh8bp0Y66dilRr2A9WONL7HlPqkMQ9J3/kDM9Mohxzvy1VUM=@vger.kernel.org
X-Gm-Message-State: AFuF++kh+fL65kn1Yb8tckzQHYGEaGD3SZIf1CdQAPlpuYQc2FLvQimU
	JEyWsSsgyIsSMA/Y1977LlDlxx9FxbJMnaZkGe9ISQIctXYbbMMcHalfUaFSVIOqcmsBFlbKAzt
	KmXamPhOUrlJgukj48tGgeIgLP+9PY/cmyQ==
X-Received: from pgre24.prod.google.com ([2002:a65:6798:0:b0:cc7:c9bb:ae0])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:394a:b0:3dd:a197:edfb with SMTP id adf61e73a8af0-3e0d6cbdc69mr7305064637.74.1791215152955;
 Mon, 05 Oct 2026 08:45:52 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:45:52 +0000
In-Reply-To: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261005154552.1508283-1-rathodpriyank@google.com>
Subject: Re: [PATCH v2] PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Stefan Roese <stefan.roese@mailbox.org>, Keith Busch <kbusch@kernel.org>, 
	Sinan Kaya <okaya@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn, Lukas,

Gentle ping on this one.

Lukas, the code change is the same as in v1, where you said the fix
looked fine. v2 only corrects the Fixes: tag and rewrites the commit
message to drop the scenarios you pointed out were wrong. If it looks
right to you now, a Reviewed-by would be much appreciated.

The patch still applies cleanly to pci/next, and on top of your "Error
reporting for AER-incapable devices" series in either order.

Thanks,
Priyank
