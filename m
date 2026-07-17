Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2F3BE628
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325617; cv=none; b=RVtbfAvXVHISdf+lvoHZFgA/9C0LTYg1CKitpXJHJ7JCb8r53bZf1Xn+Yz0T/1z/zLZW3GBcFKrPXiSqT61alGzL/lotnJsyy/COylHgpKGe/rHSyra1Q8p4DC25Z5ItWV5lNG0oZwG0IIXbjT6LpiEW9Kow8NHWgAgoLHoOqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325617; c=relaxed/simple;
	bh=qvWcvkNG2F6VP4AQ/OsjiXWkoEcGbEfuK0Svedjd88A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jCM1FBoBi4SBWzj9Mx2GszBCZPfcb00jCV4HUsa66rCxSUP77BO0SWDSBrEj1nXYMjapLQR6xB7O7Zud/TlXUaRKRv0vr8B9DOFQ8Vd4mVEq3SXCH7Ad6oCVano51XgUsPBfqZgsiMprK10cgfw3k5Xx405o6bry0CxvPPMdmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JvTK6keR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JvTK6keR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2b2c9eccso65053851cf.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784325614; x=1784930414; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ifI+MxSrxAA6sSWteBBgDksztUF+b16cD5klnXr7OpU=;
        b=JvTK6keRomGouUntrlxdqydcwRqBUmpfbzMlyVKF3zvwV+IR6VpmUygKUYjr1jKjKL
         +16Uj+dxYnJp03SEcFAUB7j4wUK7cDXaHLNpC+8OcWN8U46jrj1xaf8uDSFthoM19u8o
         ZjZdSJBeWhdCFZrXKEiiyy4txYEEqL7SWmE8QgWZAmU1WnGFDHawCJ6RIB8JEXadyDLP
         F4TDlm4GgloalebZ4LB0SDlKZPU2Wh61pyejDrvc4WAy9MBfW3VqpdoM+wiPPwke4OHK
         t0InzojDqUXHfEZCGMsXYw7412nwXP4LWkiQlA4oImbneabiiiNoAQOqbnmNy78BKVen
         pO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325614; x=1784930414;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifI+MxSrxAA6sSWteBBgDksztUF+b16cD5klnXr7OpU=;
        b=UcBheyMaNsuDzs9bSBLjs9bmBqWrdWNF4nCAXI21qYlvj6fqcsm/m7iwbExWJDyVy8
         1x4v1cpaP6PNkUOVrFWHxu8dOFJFK3W1T1JqhTW7W0Ocb7Dr/lk4j7r65AqImbqMDYPe
         QGwEAwilFvqLdusrVGnIx6sIS7t33SnM569d/8+S6Q+vQnh5CsBxiFQOUzted5/rmHct
         vw6COhT3G0nNw3Ikz6xMC+96fHL2QaP+sWfn77CD2YLCbgaa2W9UpCxPDVscUEeZqDpf
         aBC/64bQV5DVd2lU44tBDBhCVH8kx3Iw0SzgMRhiZq/Lask4piSOIJ2oQ+gYfkzvw5DZ
         3jJA==
X-Forwarded-Encrypted: i=1; AHgh+RqGG8s0f821LYOGoOV+w1iXdW7rkdajxAId3vtjHHcKst0xhRuv2+FGFgwb7uxO7u4zh7dNnUuNTpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrD8OPYqa8NILLD0BQFPESjyUbKXxu9RdJtb/Nyh6iZf23cvnp
	+dgXWcCGQtHsfqCFl7vKQ0AKzUO3IqWhwWuDAGZ7pbB42O8D4I3w2KZ3sDL8dP8ict8=
X-Gm-Gg: AfdE7cmP9vu8sdcZ9KQs8g+tSQjjyJ/Tbdh6briA6yNYASUV70ZuHWgkauJlSaPOwh7
	fJFt71SkZzsr17BIiJO5GK4saHGQETPjFAtRBHRE8l01JAZa++ZHKnd4RvBMqfpbxZ5VHv2LaPr
	V3IWAzGxP2m+9FIvNpexns01nQG0yELS+1v+UdQIBxXYm/OLOXL9AB/8cl/+VqxcGNVFYN0siKu
	xAGP5WweGC01nX2TQ1iph5Y0NzChK2rD8gF2Nwg/UcgpGQVHEOLSk3OTdNoDI1i8BJ1ly/lMD4r
	lU210Dh+BN1X8EnDnlEMDnoFO7Ms/IUqyu7+DuVVrUxi1G6rRrgEHWSNczueVsTFi/jDEuzuNMR
	dJz+lfX2sKxtu6975dSIBz5NknRudqUIwLH+fDcFKGc/atS09ievoMsCQB89hFO1V2B0engRXqA
	IVBWe+RyMa/LqYuJusATTxAqZxtuVNq+Ju+VO1jxo=
X-Received: by 2002:ac8:5fd5:0:b0:51c:7b12:5fe7 with SMTP id d75a77b69052e-5213f378d24mr42575461cf.83.1784325614000;
        Fri, 17 Jul 2026 15:00:14 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b2a5csm27038726d6.25.2026.07.17.15.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-7-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-7-dmatlack@google.com>
Date: Fri, 17 Jul 2026 22:00:09 +0000
Message-Id: <178432560931.189683.8819967076124393595.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=635;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=qvWcvkNG2F6VP4AQ/OsjiXWkoEcGbEfuK0Svedjd88A=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqXst23iQddM5JeKJBv5+L2AUkI6Q1Imib8QW
 FplXhImuLmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalql7AAKCRC7dyhM23N6
 3h10EACKK0N2VwEouy2CYlXnQQDJcHE0yJsT9DHhMi2Mje4OjA+G2J5YK8Ey9tSvDFEN4MIxr1C
 IZPZjgDZHgP6pYqeWYUKqF2adMUoo/gT3yM0xVuTHeyIwVU62yur28Xfb6YM9xVDfvGFBv6vtfO
 jm7GyFSIVeTdMitTPUwJ9+dSDxWZVL/Av4OrHAmbpsCdtjU7ipKoGAZ8mjFd1LQJQWo2r+iDqQ8
 F35z2mfJYXSEiHmuc8NDXRunjTg+VzvwBDFdMrrWDgW2R0dzM1fP9kuTUxix91XHpMwBXUIJFk2
 f6zhYw2ecfhQ9QUraWoXPAvpO/zcWsJZJTPxmwjJguJWsY2u0fWnprkQQQRUBl36KJOffbjb0z7
 fI/gzFrFkS1P2N0l1uwAv27v4n5GDfPok9wFNXYwvhEIFi9QF3y5EYHTxoblOxdIhOGcYe19jBz
 0YtAyz1zbJL11x4KiVA7vH9rRb57YZwnrVzae6b8DzkkIjtpCur0tNk7GiRU4JwFioWjr3UVcMm
 jYkRI58+ErcB766VyU6VNEEI+AOYi5hmlSIXCY4SCJEu8mnnzar4ozhZ/5GeWfJORkK0gOE8YGC
 K19l9lBFbdGjs7nS9EQtHBT8DqPt5iudHpvDhMfozA/RFMnUT8eETh1IhocLyiqY5FNzxM+SSzW
 CsGDXtheCUaiY2w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:09 +0000, David Matlack <dmatlack@google.com> wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
