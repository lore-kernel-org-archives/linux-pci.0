Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4281C5F27
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781444483; cv=none; b=PzQiGTdhNCe6KaAJoAWYR84KdShKBwg2NN44BjmHavl9Z/XSzv9vwUvsLLStJo8v5poZDU1Q65QFdPmz3iJq5W51nuZeaEN4259bsHJIbp/RY0N1RzGgO+nqdPJk09ertAtpRpvh0hFI84Q202vsYh0vJm73IutFXHPlPpq5HMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781444483; c=relaxed/simple;
	bh=9qCCo5jqZNYTFQYhvn1w10HthvCojM5bi7HQ3wIdz0Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CYFcxAF+fYfxfX2ZZA4pE6foJfD/sry6ZeE4T9StVzO7XOO+cSpwnyT5VgJUNDyA588eG/N7jZf3dJKWQCqUFAZ23p6TCLRxlXbvpFi9EP/lqBRZ6MgNO0QLwCIu8PetHuinNG7TqU34F4hIavpDUZlV2zm6HQ2AezKOYgV87v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=f2ypQdPo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="f2ypQdPo"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-915d64fead9so365332485a.0
        for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781444480; x=1782049280; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeAw+vIhY6bA9mSRruzAQBCEt99MDj9JV/iQLow7qBM=;
        b=f2ypQdPo/X5ObV2Fsc6y79srx8rOlV7wyjh2fVB2zaGZ+0+bQVIyO9k+Hj10a3QqPn
         VTFxXR5w3qk++OBbxuVTazwMZoVyg20LerCaxKVLaAHvi45qsd1YTjmGeZ+KLiawU3kD
         WspKvEgy+QtdNKDhXNqGXCFoCRDbjtIRkSFDZDIn35RZvyVgrDOHSVpvck28uxn9MOsZ
         WLc1aElcqBNLDEWNvgXqJBrZPiGGCMPJZTAotc6xyvmTs1QCMzgm+TMnUZKRuEA+HYZD
         SuYsptYgIRn9I7ij3V/DPsD6bOw0u+Nk3dgVy/CbxeEzRGj2DfyRACo7MUlT2CIYIEv6
         f8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781444480; x=1782049280;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeAw+vIhY6bA9mSRruzAQBCEt99MDj9JV/iQLow7qBM=;
        b=aLo0KDLxWeWwzW6MYQM8GkRtDWlYY2HmnZEPH4oqYT4m5PoTX5Izz4ehF6zY+AhjWw
         4pEGYAzA7tSfo0Z55a7qqIDMZXjtTcLW+S+uiX5GzhuPvH4nwWV8yYA2MthTrPeH9sPU
         s4M/6b0qYcb/7+iGas/Gxz+MS3xafjDXE5PZR2z9RsxBLymOxBZVjHaBe6pVQKLgmy3X
         FeQcgR+u/SiLOGLtSFQusNSG89hN/Qp9iuXknmIgWxb4M6/3qMKxxGlJN6CJonuH3eFJ
         p83BF2zMgQoO8jSAP7d6hDlBiyIftpiXjrk4qiS3dMXykUxP+xS5TIW4SJpcnZjEO2wb
         FyJg==
X-Forwarded-Encrypted: i=1; AFNElJ/dbD30pVEUxqYsuCCxrwvfFe/DgEPot6th8TF7L4TmfGssljbi9uWArdMvJR9TpYhqGHiQ1Jlcwvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjndwEJW3Xv6tcBeqZRJwjREaxNCusuLjjhndm/gI6WEZ5q57P
	SwUyv2H+01BuTAsrePn6P0ADRw07vBc3+0QytYZCUgbC715WqWjmZwTduuh//K7pU9o=
X-Gm-Gg: Acq92OFjmZ2xbUB8Ugl9NffHlNIbocIzwEB1L87ye94UBPT/+ap0JMUQYuWD0GuyQM7
	CKrhKG4lw51MUX2pd8beIvREaInbGwPf+RCy4+qJzaftSavsxvcejveqFAMEI1jEc/dF2VuuDfP
	eG0o2dj2FAFYInrbtrt/Ju9ei7RUWDa8PEEmyXrhgbeuzd1VHMkuSh5fZxYBWQPKFwd6a4TrkIn
	757EOOXQ5GZmO6l7FiSt1wFINZXVBFFgND8xmtngeRuD46Ci3VVy/+Eyd8P6rtHzUZV29oxzSle
	YGgpBY3htlZQTge4gsLuMbztuOSLLGrV5vy0pT29id5HB3WTHmjnDVam1uU/AKsijeLufk9a7wF
	lhTbtSpnKnLN+aYHicwNyzU/zu5YcfUF/JzvxFmKW8PZTgB7U4YwaifwnA1/E/ZK2jaPG9YNIw2
	GijqaaqZyq6mej1DFdoxfmcyq93ubw27HIJ/xYIoe0gwhYmgw37SCb2Dr7AXc/3FhJvsW7/CA=
X-Received: by 2002:a05:620a:284a:b0:915:80ed:8327 with SMTP id af79cd13be357-91619f73cd3mr1359281985a.41.1781444480052;
        Sun, 14 Jun 2026 06:41:20 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a00af50sm804255185a.30.2026.06.14.06.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
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
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-5-dmatlack@google.com>
Date: Sun, 14 Jun 2026 13:41:12 +0000
Message-Id: <178144447224.1257322.6028717050680465656.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=436;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=9qCCo5jqZNYTFQYhvn1w10HthvCojM5bi7HQ3wIdz0Q=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLq9+V5ehmqYdW7aqY5UC46rzyaBztHZtTXaEV
 wNq3cD8aFeJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai6vfgAKCRC7dyhM23N6
 3n8VEACd7+ln+qHdtrY009zcX3HQrr1PUWTlugPorIeOn8XmTJbgYuCm1D7mH91o1Qk0SZe2+wI
 2S0wRpAHlKaOVEtO68gKBmhZPDreEUWbyJPh2baoB7PEM0rHohe6beLyk9a0EDGyMoizfUQVlBE
 elPL2YdcMN8btmVGap5fkjrisPb/6OsmU2lUYZ+KNnAx38aUZVcUvKDewIbq25zdwlZBUKGecSh
 As9pDuvz/CVYl/3F2pe1wWh3q+WvNwNasidlW+NrS3zSIJVb0xbHv2NXEnOUJcJ127swxUuqvNJ
 Q3siNX2gD5B3zi5rElvySm4JdLzs16A2WhlbSrwn1B93becCXOtZ1Opap0noIZ3rbnK57eIq2nD
 pYRAwOqOK5KN423EhDkvTAWZGYyxMC9vWQBfaAa49JbYobhWtvnGWr1ezCJ8k8bEcf4RRLYXcoN
 8xYz7NI1pblzXU2nq5qcyacPiWBzU90F28R3+LuI6wz45GMTbHQZJynLNwaWubYDsQjEZHym77Z
 X+89BTifV4853SOCW3d5PdFyp+NqcbzEkiRaNg8G2v+FxPzIY5B2QAbioj9U4pY8gLM/BoLASVh
 xtPEpIr93n5If5K9gYKxSJDWp2YDmXIBrR1LD3sDnJ+q/TjpSVubUA9Pu3yUcMq3lQZSfZeqnKo
 h5XFZvHeHeKTbBA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 22 May 2026 20:24:02 +0000, David Matlack <dmatlack@google.com> wrote:
> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
