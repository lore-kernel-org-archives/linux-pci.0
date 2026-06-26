Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307A18B0F
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782435002; cv=pass; b=agPMbY4nj+Z17YAnFrR+v6GRJvLXo/L4ttfIczp30bi6LbcyUXz5gE5GOJuTm0umL+qwvkGaSAo+If236HKQHx3mWLZuL46y/Vc3GtGDtt7v4KhsqROfFLds8SdJm+IRmjyen16BnqIWY0U7rMP7zGee3tCDbEfv5PGI+XXYi2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782435002; c=relaxed/simple;
	bh=0LDqzaaHNbz66SxfMUxRu/pXNL1rG9CYeDr2NTKSg0M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jBpsh/rUcha3PA0susvhr+ifnmiFIS+CuYdKR5BKynWYruFZUpAQ2iiDhk+Rj74+cz72XYT0So7Jpj2vk+w0qGu2sIDg1EwOQM73nrJ6IRBnkx+vl0qy2wNWgkiUVOQ8v6L0hsX6r7WgRiFjSJj5xgPthFh5SV3kCVZ2X2G4rLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6xJy3dh; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6xJy3dh"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9678e31b45eso15894241.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 17:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435000; cv=none;
        d=google.com; s=arc-20260327;
        b=LEAIm3LL2AgVzhr6DGTy5Pp9FWZtbFzC2eqNi1n3Mz02Btt3LF5IRhbjgTbKCGhGOa
         UjVKVY5kIA+1o2ThL7eJX8KL7lezQL2LtM4yqR9cd5uwFzkwps5Ms8a9k9FP29nDZ2Fc
         Es5ctrKwZug+rD5okNG6ZpgpGQzzFxx1jUVQuw97+4a5CPMFJgEa15R+JHYVnpPYd4hv
         IhXlaZyjmQTMu8LXjZhcaqqoD13ZhWNb7qsz8CuBuC32N8zwLtzCCtoDdozwtG0lpqgA
         LSOxeyOh4wd0dPrL2L/PIKQHW/qzY0UEtT6SY4l+hGe4zdowrdx7grMW5VYN2lU1LDsB
         tZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IKsUtZgg/mAqxuium15Y/FTanwgz8DbVx2jBcc5vyq0=;
        fh=vkROneKyGtBBkhW4X3W2QcvhpyRHkzkzDSNIoDMqt8c=;
        b=K66LlMg7PlSZZ2o54fImCmIxajMDyNHghBZcJzC6QIgn3q2E2AxK0vtLoZuVqwJI66
         xsn2Pf9rOnNawr9UouZEmDzBMdTAWgU6NjRLtEU+q692wIf3s0IsxiQ3SKl52gQOisLc
         J96DGYwzsxDD9b+wqWoFmwO2tElavmE6SnRHr70Z8DpercbYHupZnsA9LelyheTCNfZR
         p4sh3rL0rELBCHuNVnU1UeV+U/Qk25afYoR/9z8wv+lATtL8J370tXAk+jc9n7Nw4QGl
         JlN/VJ2+4h/Uf5cFfR+ZECDKnjlrVbEJWSjE01UcH6Ot0bHH8D1z0PuF46BB3Ab3lqCx
         1GbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782435000; x=1783039800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IKsUtZgg/mAqxuium15Y/FTanwgz8DbVx2jBcc5vyq0=;
        b=P6xJy3dhYXCo6rbO2QRtZx/7O9WJbAfOo4px0jgOLlGphYA2nWHgGwlJ7EIuALnlCk
         e46a0mObEY575v/qIs6wfWgPkOgxzCmtjwmyh4zvH5295W0b+iyET153+Qx+8kQRGL0n
         m8CxS89XbD2pmMioAcyTpVoN6nMs4wnc4eUrNgnQ+drh9inU7CzuOuf2SJ8F0fm7xUA/
         dMhZWOKp6wFLClS4ke6JQtwmaq6/iY+Fm52AJ2Fq7yJIK22mPQvddT6M7VxBXCb0Opa9
         N+0a/QgATm5FYHNJj6AMsRNqMoTY15Q8E6i0hVj2GwxznoEK7Haegf1cW7Z8bCUtrHUp
         yILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782435000; x=1783039800;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKsUtZgg/mAqxuium15Y/FTanwgz8DbVx2jBcc5vyq0=;
        b=MXhddrBBHUMSYSDdR8/RDiGV16I1E9LVsBTbWoENBpxc08YsnQnbGvYdy7oQ7eGbu4
         MOs/bttIpRUy47dRGam7tLltCJyPACkvRbq65sOyUBJ96ZZEdMrvDUlaABZnKw5FUYol
         ViewaEEAzjb99sWzHUNvfVNp796WHXhZGwDbR2lQEfbN3crL/fZ14DJgDBiKzjcgvs2e
         wTHWkg9Vfi4kRbbe/ALO9sWHUCSQV65+O4l0Il9/Wiov/G2BKZ5LtyN1tj0r/cn04d6b
         bxdL6ezLpX3njY4whQE3Lh64Mv8Wxpl/7KwQ3wh8w2Jy3u9gdHTd3e9wrlJklSeYB/Vy
         EPMA==
X-Gm-Message-State: AOJu0Yze1hKoT4YHY7mEysY/l3gtJg1DN1eNUv/xpOY9VNpj/5Yu5sQX
	YAvAepm23DuTImZxIiC+RoyrrJd+My+ne3lgogZpSSqYWL7SDOeQDi3pECm9OH56SC9oEr9rcRn
	Y+Mwhzzu8+6olSINiB2TqNnW3LyI1eu5LocDG
X-Gm-Gg: AfdE7cnZCgEGpz++xuIFoNDCXZQ8EeurR3m39QTiZHHX9ZGWDy1+4NABTU8ypNKS7CO
	LiS5sH8HDgtCUttvlPKAYVRTBy0Qk/+jAT/+pQGmD7tXDTU3VEQ2ADyLdkdhax1vFHqumcdu3HI
	ItMCctS4ygGiAmg8T8BRwAaHAIgaDwGifiNYGEQZpcKlRjRDUFVkuhr0maxR2fl88icfWXVlCxU
	P0j7dhRcvhcuB7Hhi72onKliD274qfXIMCXJB3wOgxyrUPHq7PaDZpw1QKEVgOAoXKxQ6653A==
X-Received: by 2002:a05:6102:4b0f:b0:631:4385:15cc with SMTP id
 ada2fe7eead31-73429a89d35mr2098234137.1.1782435000147; Thu, 25 Jun 2026
 17:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Guder <enyalios@gmail.com>
Date: Thu, 25 Jun 2026 19:49:48 -0500
X-Gm-Features: AVVi8Cc-rrxzrLUTHuY3IJcL8YVTRENTSBe_3ruD6o9Caa2AAeT3TPUxMLqb-E0
Message-ID: <CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com>
Subject: Wireless Regression
To: linux-pci@vger.kernel.org
Cc: krishna.chundru@oss.qualcomm.com, mani@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I seem to have found a regression with the wireless on the thinkpad
x13s laptop which uses the qcom chipset. This commit seems to cause
the issue:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=f176c47683bf

Any kernel that has this fails to load the ath11k_pci module with the
following errors in dmesg:

[    7.298226] ath11k_pci 0006:01:00.0: BAR 0 [??? 0x00000000 flags
0x20000000]: can't assign; bogus alignment
[    7.298232] ath11k_pci 0006:01:00.0: failed to assign pci resource: -22
[    7.298234] ath11k_pci 0006:01:00.0: failed to claim device: -22
[    7.298267] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci
failed with error -22

When I revert this commit, the module loads cleanly and wireless works
again. Please let me know if there's anything else I can do to help.

-- 
Paul Guder
