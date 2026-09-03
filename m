Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7D4A49A5
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439733; cv=pass; b=gqgIXMgcDxOJWF49pFKYp/QQ0o23QrCFqAmUTIA35U9IAvOn+0cfLri+yAubUWvIJZgXBn8FhTyugZfpBhytwwFJlhmuhqJ5M/Mec9mb8k0ezi6gGksL3vy0Hynf7HOnDfu+PXNp3AwQdeyD47/wcMnZA9jwWQ+XYwivVJhy22Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439733; c=relaxed/simple;
	bh=Ht6j3zLO9mOTisTOoQA3QVTAlAp9tFCgmO8Jhf4tZdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WGevEc97wsnZc6cPxqE5DDIuSzNxrJObJqKKbqw06KP9XnCR0KAiWowYRC2PB4zU8Kr5muc4ncKzXLr+U4HrV82XIvSX49CCiJLrRjRTBY5a7eoOeerUH8KX9vlxwSC4axpGcjtRB1hqLHme0rnvyDUDkA5qSLWcVkPvrsG4Rys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6uBhAPG; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6uBhAPG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8706dfdcd4fso2453687b3.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 05:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788439731; cv=none;
        d=google.com; s=arc-20260327;
        b=A4n2jjlnNEOoVsnjAr0HAUgqlvvI2Adz5qJyei98dUv59+Dcz1pDoXCcWniT2F0aKI
         61B+XjDRpWYpoBgA6Cggo6kk2FDUS8WKCNEH2vsxizmI6IwHs4JSR4aCgUwDc/92cHID
         ckE0EYafCpCe89ULZIwAmuLqA+PeKA/YL1FJWytwQJQBqu/7J1pdTOOr4vru6KqN1/SI
         ZhRIUyuYHfO0ys+wJw9OubCjdVrhch8r42CV64EyGRvzcOqzU53ZPUnM++wNC2P9GvKX
         RKpQaWhpGXRjsQRBL+JUAbYk8lKuOLoqtIeaoXNAHQ8VX+hvTGr9lofBcMmx3QB6HUjS
         9QoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JK0+ujBLCx8kI9p3rwsu8Y5QpLujD1N8DDIJxGLtgTw=;
        fh=g6PaEf42RMMguKrU5jnTAlRpigGL2ZdkSRhdx+LR2Qo=;
        b=Dg0cftK81Lp8h5AAPruw5NNy8PkqrBH5Gndd1Lacdj4etaPSgh+p+SVpthjdwxchkf
         ewCu50vaBwrQxbGODihPuFiXqwStTBfSRLO0povaAYfxij5Gqjo3Z1kJcX8T37CcwcWh
         taGaMufIZcT4DpCKYgGS/sx+o0ZlMEZcppKOYN4G50xST9nOlRWsICg0dRxh6Tb08vUK
         Qi6cmf3sH3kTVZch3RwgdK7KtSAYb94DjA0/1BY+20ISnED1bBcyCBYcXWSMwv2npKzm
         FnzUCH3zJS0pkOEowH57RnYqovt9mwuQ4Z1ievOhHrP3KvWILNVPXgVHQQfNqUsw9q6p
         mchw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788439731; x=1789044531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JK0+ujBLCx8kI9p3rwsu8Y5QpLujD1N8DDIJxGLtgTw=;
        b=C6uBhAPGzeeYuJBvofeQmSbC8mHU6uTkC4n9pLaDS9jEo3eur//6Dh7JDhJAvyjxCj
         Vsa1yCHiPru6tuGqaIP6C/36fn77NOfGyU4+j2H6KL1EzRoSivBD5hPJGfptbMS/UJNP
         jmuicFnoD0ONTkrPKQJ/uPANXyhDm5+Gu4O8fu1KWx0lMVeLDRqal+VNIGnY/yQWMI1Q
         D53xG0x4IWQ60utOEmo3ZEuTY6YD9ccBFvA0rKWQvWPnWEnNPG4RHjNi/LC6yU+gIl32
         u6z/ApSfkhihaKCU2DSc97Zl1N3Q4lKkpV7XyOYhHtS3YFeFDo76u/TCfc2Ni+RcvWBN
         Okig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439731; x=1789044531;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JK0+ujBLCx8kI9p3rwsu8Y5QpLujD1N8DDIJxGLtgTw=;
        b=honY9/bUFFooMO4yDu3SpjR4kssYXaQj1HFySA5/kDomftcCZh7RCDe9bWUKluw8eu
         7HEdIfLnkYI099RsQh7Z0Yf2BH+qYqkFJH30nQup7eLn0qRCMLpTpvgWG5aKRdPpgcR5
         rKP5PB9jcqPZV7Cib2Xib7MIO4yHfVzfssXjAnIRRZeGSVMLhF0RDk+qTeLThS9peuJ6
         MCnKfggjGt4HDv9/y9CRTpjplxko199n2b68mj9OzOYy5caYwq9y1SMuCxh45Q91astB
         yZJOUPvudUu1g91lixbfzWFX+UOEJghjE1UtoaHDmT0oXpi/OE7myUJ3HkOnqtcKJaNV
         9tFQ==
X-Gm-Message-State: AFuF++kMgu7Kel/om+Gq6SY1kMJbS+8j2dP9PzqY1rlSnDK9JF3ysIKn
	Eg1gcGUbDteeW1K8BGiVNSeERXJOjm+LeV6zrEo4HKtWBcnEEErpW97mONupOGdBVDMhWfsMIO0
	7ckFYC4OTwRnumgYGvwWlV3IsZ9Xo4VxOjRlk
X-Gm-Gg: AYBFou0QFtvJlZRUPm74rIb1mCqSEhX8oX54IhB7kW0wSDB1p/IOrxQNCLbQ6scMytG
	doJtrsl29St8r5xR+e2OUTZ2FsirrklBYcJBQEpcrE5XZs+CVV7he/H62Z6gHnI0YE2NCY+y7C2
	itcfanvV4fB+8R2AweZmJgmpacFUN1gnh4FaoWPxlQvDQYnTMuXGLbPxGY47iXwGeGAdpPwJ02B
	xpxt/027PWs95TIBJBFgmFR2N4U4KCRCnXp9X79SVa94BdUtx3yJ1vr1Bh1iGySC/DP//+Btzzt
	a1pA/tFIZeUuu1bOFUgB72/xPV5zOZaoeig2kTSdG3HQYe7bEG7xtzjl0sqdBawMH/t1kfK2VWj
	GLSYbCvglHC9ObSWctM2mydIeWPjPX3/wDGwz0M6TzYsEUsElE0h7eGSyxyJQQJPIJdG9uFqx7q
	muIAePgWartHD2qaEaRo4q+hkW2e4wkHmFOxi1u/q9TAA+N0FRnF482enldUD8fooqUvZLSSpYu
	UmF85AGJUh4vJc+6bwsWJ8sNS7L6f8xw4w9ripoNAOdDXUAcPU=
X-Received: by 2002:a05:690c:c758:b0:861:d4d3:513f with SMTP id
 00721157ae682-86c4e018e56mr57634177b3.6.1788439730708; Thu, 03 Sep 2026
 05:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1787602802-28614-mlmmj-37e598fc@vger.kernel.org>
In-Reply-To: <1787602802-28614-mlmmj-37e598fc@vger.kernel.org>
From: =?UTF-8?Q?Jo=C3=A3o_Muzzi?= <joao.muzzi@gmail.com>
Date: Thu, 3 Sep 2026 09:48:39 -0300
X-Gm-Features: AcwNN1WmMlD11MZWW_XfZ0SSfgxa93Tk-Vkwny6qdkpUsXDp9Lt8SJLETF1tbp4
Message-ID: <CAFvqgLzeHcBK+muVuM7k2g9XpnPaDsF9LDz4L39cE3gHSJim=g@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
To: linux-pci@vger.kernel.org, kai.heng.wang@canonical.com, kbusch@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Reporting a real-world data point that confirms this erratum still
bites users, since the workaround discussed in this thread does not
appear to have landed.

Hardware: Dell Inspiron 16 Plus 7640, Core Ultra 7 155H, VMD 8086:7d0b
(subsystem 1028:0c94), SK hynix PVC10 NVMe. Ubuntu 24.04, kernel 7.0.

Symptom, dozens of times per hour under I/O load:

    nvme nvme0: I/O tag 201 (f0c9) QID 1 timeout, completion polled

Measured 154 such events in a single boot, and 104 in 51 minutes
during a heavy build.
Not reproducible with any data corruption =E2=80=94 no controller resets, n=
o
filesystem errors.

Ruled out: kernel 6.8 vs 7.0 (no difference), latest vendor BIOS, APST disa=
bled
(nvme_core.default_ps_max_latency_us=3D0), pcie_aspm=3Dperformance, and
SSD firmware (none available for this OEM drive).
`nvme_core.io_timeout=3D5` only shortens each stall.

Disabling VMD in firmware (Dell storage mode RAID =E2=86=92 AHCI, so the NV=
Me
attaches natively at 02:00.0 instead of behind the VMD domain)
eliminates the problem completely: **zero** timeouts on the boot and
zero under a 5-minute sustained I/O load.

That is consistent with the erratum being in the VMD interrupt path,
and suggests the dummy-read workaround discussed here would benefit
users who cannot or do not want to disable VMD.

Happy to test a patch on this hardware if that is useful.

Details and measurements: https://github.com/jmuzzi/dell-vmd-nvme-timeout-f=
ix

Best regards,
Jo=C3=A3o
