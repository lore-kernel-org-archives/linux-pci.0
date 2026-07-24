Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E523B5821
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912933; cv=pass; b=CpD5pSVSeJ16fKHxszpoQ6uB4mtaLDw4JIi84znDBKsOgMAwd5jfRxm4RqTT5b7MzgC1BwcILM718t8uOIixfgNxmm/Mryhc802rIlT+MOmT4otlVx7vJNYciiGxaNz+mFEy/QRVg/yuomCxDTCOO1K/PgRDC3y/TXwFPnmjUN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912933; c=relaxed/simple;
	bh=o6QFhMA78xOTT6DqNK4oOLhsB/pOTYepo8N9N6WpM3o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oYphD23HAOyfdHD/B/VWGpYxjCQpQ8AdjY30C+8eSRXiMu9a9lQdiOk/7CtvgmW4RnxuIh3GcLAWlWmQunPL0jWINTBovwSdQCozJQzqzFZkUF2NcS45RDQaSDiltqQ/DigSnHSQRUEUsC5J/PnkFfzO187zUk0c18ozY3dAXKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEHhPAdi; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEHhPAdi"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aae73c40c6so512432eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 10:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784912931; cv=none;
        d=google.com; s=arc-20260327;
        b=nHt5knWm9jnBK1KPt+E8G1CYXZM0b224M+1YMk1GYf/enf0JiKitOpia2yzcEFsRMg
         byS6bdhH+8wnlv7+JPveWBUwcLonwYjGPjdau0mPVqtBqsO3emNqiC5lGKWJLA+PU7l/
         X1N4ZlYrNwKNu0EOF9E3TY/MdkiI1ECFrb/yKKKlv0NjB/Bet+J3fWi1718QdCflAIIs
         XnbCxJLS3FieCqegvXtPAI3Vb2LMfsbfQWmpzH8225A1qqJY2vBzxuxmf/Ph2e4XUEJn
         SuCcGgXI2j1zXdE+Da8H/WTxDJI2FbppcOMivygk5U6NUoSbck+LxlmUQp8UJZSmPKPC
         U43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=o6QFhMA78xOTT6DqNK4oOLhsB/pOTYepo8N9N6WpM3o=;
        fh=TIEYd/98UZ7TP1tlKRo8Pp6W+9APmfGLEB54vzHz3j0=;
        b=M7d/fNifruLWPLZcjIJbORYCnYH+w/vZxtPw5wM+3RXFsShTZTNtDO08rNrTdkghKP
         4XhX1BGgtk7JoQFU/LXRPZp1J+1NYWYBCP6b/uZb8wy67AhrnZWJuTCP6bymKgsFeLoe
         g/kOYxmFdK/WAbyCIQ2nQM9nWykIFgZIzL0KLesaw/AVEoiTP9W4yYdf/RbsbpXulhNI
         DtbHLwejJ0CxmMXiEhRr6dN5gfYH/JEJCgJf3QoNJ3ZPKVrLrpzkWwQmBmFCajU+Ni/w
         lIZb1F8jlE5+ephoD1+tuqW4N0mDt+XzGU9NXRYq2L8xSqsfS/ndFYN5hxEubQTY+Tyf
         TNDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784912931; x=1785517731; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o6QFhMA78xOTT6DqNK4oOLhsB/pOTYepo8N9N6WpM3o=;
        b=bEHhPAdidNjE7QpJL28E0ughPPUGmB5zegNgzBzrROZ6lK6Rc4oQmm2cxWvDA6sEpl
         wgPutnlkppaFVdXdQj6mLCQV16OwuRXIDPoiEPqhH/RH77CZCNueLkzxs7HNdjXTccoE
         28FQmus9QY8vDGwal70bPeE0tZtPANkZJGykY8thznmEI6u8MGvp8r4lN32v8vQJdMPp
         r7OqFJaoAGYTgwjbA+6Eo58Mp+HZblVga79tBjn5R+3EiolWY7+cySWVYzUPvnvszCje
         o6609vw2gJzKkoTCBJARYQusXUPBr1gPqZg1zPMkmYzW7A1qjCiA1D1q/SyeEWwg7CHD
         BpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784912931; x=1785517731;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6QFhMA78xOTT6DqNK4oOLhsB/pOTYepo8N9N6WpM3o=;
        b=LBuKz3CPkdJtrME+mtP87/pDbHU6dDPov00VbEhn6c/+yrLOkBTQIFjK+aNxgF+MjW
         k5PmU24IkX8Ryx6JMzwPCPmHAITWdu2hOLvIsyBzz1eaT7/SBWlnIaUxzyfPRTGYNTE8
         DfFf6AZFJ5HVn6C8SEEjZ2B7pGYpzGkIuCJbVdbPx3DVi6wbWOiS52OUco1Id9kAjwmg
         xFq9TOLMKWRE0pMm5n86BYGgjbyOvTZLrzA9A9qK0TqAO7zZVCSN9DPazjNXjQvwxQ21
         b8+pkVbpCb2JULyvd7TsMqnRmQiPWHN/3PEVgLD4mhcwpu6DieMIMkA5JkHwteae1W6v
         8CUg==
X-Gm-Message-State: AOJu0YzQrPh3GsnW0kDAG+4VrU5EQRQlgfhz5coFgxqNjcYmS9gH41DE
	HhJ4GblsmJwBwKV91fkXGYW05YhNJdzwn4O2fQyt0uUgEn/ppjt92ILmgmi6XnQwe7Xm2wWe86q
	lK10ikXApxk3eCPE7XwoN08ZyvjXYfdHzes5n
X-Gm-Gg: AR+sD106KueBRyKNECkZvFIU/RXMtl5RR+BomGJInPBUJWFBnetWN5882e1oCQM8QA5
	UE07wYLkQPxEriT0Y+PWrFPwF8n5S/7Ai4Yi/BVVetTnZqUjzF8EYGmKw+nt0udHf7j0lxcQ6TG
	ZeM+9WRFukpGimyOUkFkHhxT7hYP+IYvHAykYf5fBkqaCgD+FIUwFWkWQiFbWd2/9b/VQwUKRjX
	MZqGFLG9D2mVzR0huNeglqw4I/b5L3Y8TdjqC/rkGeD7JqK2MqxRLAISlsWqw==
X-Received: by 2002:a05:6820:625:b0:6aa:e267:f11 with SMTP id
 006d021491bc7-6aaf42b4d9fmr1237502eaf.12.1784912929865; Fri, 24 Jul 2026
 10:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rakesh <alasyamrakesh77@gmail.com>
Date: Fri, 24 Jul 2026 22:38:38 +0530
X-Gm-Features: AUfX_mzbWe3GYvVDnp3WU_ceLnxCwN-vmMePwoPWJ7VRJ2N2_wSwXtM0XDqkowA
Message-ID: <CAMizObnmGPi9rt49LfMCK-XFrjfZSBkJWwp4_84X+PbeRUrNrg@mail.gmail.com>
Subject: [BUG] QCA9377 (168c:0042): recurring PCIe AER RxErr/BadDLLP errors
 with ASPM enabled
To: linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report what appears to be a reproducible PCIe
ASPM-related issue affecting the Qualcomm Atheros QCA9377 wireless
adapter.

Hardware:

Dell Latitude 3500

BIOS 1.37.0

Intel PCIe Root Port: 8086:9db1

Qualcomm Atheros QCA9377 (168c:0042), subsystem 1028:1810

Driver: ath10k_pci

Observed behavior:
With ASPM enabled, the system repeatedly reports correctable PCIe AER
errors, including RxErr and BadDLLP. The issue has been reproduced on
Ubuntu 20.04 (Linux 5.15.x) and a recent Ubuntu development kernel
(7.0.0-14).

Workaround:
Booting with:

pcie_aspm=off

eliminates the errors completely.

Additional observations:

ASPM L1 is enabled on the link.

L1.1/L1.2 substates are enabled on both the root port and endpoint.

The ath10k_pci driver temporarily disables ASPM during initialization
before restoring it.

I did not find an existing QCA9377-specific ASPM/AER quirk during my
investigation.

I have filed a Bugzilla report containing the full description, logs,
and supporting information:

https://bugzilla.kernel.org/show_bug.cgi?id=221784

If additional diagnostics or testing would be helpful, I would be
happy to provide them.

Thank you for your time.

Best regards,
Alasyam Rakesh
