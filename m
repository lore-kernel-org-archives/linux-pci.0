Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48B2D46A1
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490753; cv=none; b=bzEYXjpN0840/zSNFwakxPC3EqJFOgrvuX7U8oSgMq6N0+Ckwyv0SolhW4sMG0vcLMdPLsBNHnjJjFoXA8+DEa13ztyY3M3/Ehj/SXLiuzNQuKpQ4tVNZi6UdCiiwJPBZwtW7pkvIk2Ypl2b6pVCIzc7bgCHG4See1nS0W6fTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490753; c=relaxed/simple;
	bh=P3KGJqvLDVQEGw1qKiFatH8JZpCFUTHLvw8aN5u+gYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+t1nu3Qa8AcJUNEQMrXlw3rzk0LKCYzXaDqKXr44JqkHRBFyUxCHBl6Jd+nO/IiUaGHXFa0xPqw9VBOhG/46TzGi4kMVEzp8BUCZh7bFLU4YLhJGqGiMik1Gc1AU2vHPw4i9Eg+4fVza5TCmHn7YxkADmHKdp5htkxyxbMI+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBqHiJDd; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBqHiJDd"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso577573a12.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 19:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788490752; x=1789095552; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P3KGJqvLDVQEGw1qKiFatH8JZpCFUTHLvw8aN5u+gYM=;
        b=sBqHiJDdKVIO0hTeivgkpF4DwsbAQSasR8LFgpAk8JcbyD0EJX3TEOhXmk9vIyvu1O
         UiCdupVTGl9/dvSy9SO0b6lXbGqTMMItwlT6I/aBjdvUqYxHtW6IdNGzABYjmTTztWR+
         soUb9OjWP5GOZLAmqc4pagHsJKpGT345KvIudX9di3ZMjCE+3whY6bPs3x5ftBwHNBGn
         kfyxlNKoswj1CCBnxcEE239uYWiBoKqLnpXuQ4AdA6zIqqaAVnkCqjvrzq8AR+6rF5BK
         Nbpvn5AEa7jGeYhtgKALDOmM2MW/lG8ZDVQJiRIJTY1Z65WRoTp2pOSKfllZXcpUIT8G
         KH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788490752; x=1789095552;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P3KGJqvLDVQEGw1qKiFatH8JZpCFUTHLvw8aN5u+gYM=;
        b=OEifdDO1GhWvi6nuAvDnlUZ3dfkryfj2KY4GxeYi9oSGCS43jcjRGHLyueHphs7NCp
         TyKBuydAyLsYOuqZJuPfZ3/lap05xak0rV5ilzknsYnP4HYIsOYW1PX0ErkcMzj2GIhJ
         J41NxUa8hqz5lW/ErlLPIqEOovGOh5u4oNDXViqgz/5bLlRQLhwqSS36f9h2WFPMopIl
         Vmh/z25hz2TiLUj6qognJvyHgu6AoyR9hHdN+30gMBePDCa5rkN37VVFr8VjYwrXciTK
         8hz0zbWVHV1xV5wFxpZAFO8MDwVVjpcZeP5hrB7kOxGV5Tm11pPZm9cBeF2VmXkW/l3A
         UVyg==
X-Forwarded-Encrypted: i=1; AKwUvBwUYMmLRRACEP39cGcr2LXgt6pAj1zN3dNY6Yk8nnQZu0XCSxwHorJxYRt//wG4g0HkU5cteAt3ABU=@vger.kernel.org
X-Gm-Message-State: AFuF++kVNUqQA/x/3JqBb+zDrv5BTd8uPoKjDx3IMMoT13EQrv0vc3w5
	llsLdxiz+OLWYiJLUPQh08pj6ScVdM28yuC7g5sTSHUB7/v/8RlOes2uyckJGOk6W2Fm4iUjyj9
	pcElrt30znVMPdD2f/gAWUfXcG1wN8SnadA==
X-Received: from pgbm1-n1.prod.google.com ([2002:a05:6a02:6181:10b0:c85:6deb:ee45])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6708:b0:3cc:eea9:f757 with SMTP id adf61e73a8af0-3da3a00565emr4270762637.16.1788490751460;
 Thu, 03 Sep 2026 19:59:11 -0700 (PDT)
Date: Fri,  4 Sep 2026 02:59:11 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260904025911.3960034-1-rathodpriyank@google.com>
Subject: Re: [PATCH v2 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn, Mahesh, Oliver,

Gentle ping on this 2-patch series fixing two memory leaks in PCIe AER error
handling (ghes_estatus_pool exhaustion on kfifo overflow and when pci_dev
is missing).

The series has been reviewed clean by Sashiko AI and compiles with W=1
(0 errors, 0 warnings). Could you please take a look when you have a chance?

Patchwork: https://patchwork.kernel.org/project/linux-pci/list/?series=1139683

Thanks,
Priyank
