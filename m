Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC53242D8
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512015; cv=none; b=Qzx5PGeeIIuM3Qb63tovNfhmKS3gclJ+ysRD0Wz6TSvwRpQgaONG8eepComNzAthwFJEvVQtkc4gRPGpsJaN1l6b0gbv9uNGziGZZwN5k9X8F23UPcBJDUEGMsumfPpUAR5HsUMU3kAFWykZ4gjPNJ3A33Qyj7F0c9ENArbiIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512015; c=relaxed/simple;
	bh=/z/AIXjP5xC8tmgQZbu0/9zQ4AmOQmgco1dpipNtm+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DB43ItLM1kbH2xtqci5rQtXd4DSmnOSdSAoP4W4ppd3GxHUh8E6MRCLU4P2q5v6Fcb+IfYRpCMlyhVHsyREPXGeHnx2DQt743LjLM03DYC+6qY1W7j69N3zIpAfxri7jDnoiE0mK8tC+vTAKPtVjA59hxerNh34Si3+q9C4vp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ5zKgJS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ5zKgJS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso358139f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774512012; x=1775116812; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7el6WA6ZNZjfmZVGd0QgdCpCIt3VJT2LRu865h7uJ60=;
        b=IJ5zKgJSeQ04v/Y43abpxMQqMq2+xvywMIpDUdOBB+GBNwuWFyrPxyApdJ41G5Hr8b
         ZcYJjaw+0KXEUCl/FF/0HbPPC9htzQUV/Xu9C7ya6bgALNWP3ackbdNiO2jxAON6vbDQ
         rwF2WBhr3FuFvu18Gg78TVr3wvWgXI0X5e45f8nmT+4CxBHohNYEWg6QRGlL7qU49hch
         oXbD5lo/6ie40ea5ogmSJn7lraNeA1yvv5cB2zO0yuF9ue1/9xAOl+9uWkG1995MMeUv
         DQLJ43HqzJFpnSIaQXzTA7i85NjhDilt0TWlF3jc0PHreKqd2Jci5tdfmalMFUgifa0p
         aCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512012; x=1775116812;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7el6WA6ZNZjfmZVGd0QgdCpCIt3VJT2LRu865h7uJ60=;
        b=F6YWpXmbitc9B67dp2P5kJkMfcraAZKi+lNEDRK88by1xCFZPiNGDvTc4iRTdYZEsj
         tZohyO+V7BAWvVjwwQwaoNCBurgyktDG0oYjyBLq2qS/OeCFOge9oawODJDZD9HV86GR
         LJTeYEga7Jj7r18eD1v+r3dZgUmFKiWcKW/6z3JknCgX6SKqy9pO0VgM2CDGvmXzXe/o
         3vlJBCht6SCK88ddc8u8/p5Gg5516dLoCdNZ6delchmmfOhaRB+2dpZJyK0p7rLNpsG/
         m9jhGAOYCBbkeJD9xNLfHZi7Im2YjOGS65B88IgeOhKvxnh95QHAMUsdZdclLCFaOGto
         zxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3NNu4MXQfjY8qlDExlAmxclzNW1A8WDVyJb9sxsOjOi1o78Y15K1GL59nLygzV6TKIi0uAB8wcG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWed138Bfg6by428XsVY2zZWGQRKdBvN9Ka2YipvqNbJd1Ucq5
	9p+tMfv/3nK0k6uN3caALGPf8iXPg0L2YRoT+UFqBbzKQHXYr3hTSDTRM34BN16k
X-Gm-Gg: ATEYQzyrdPa3UImy0Ee/ZtXaGcH0OEz5xLxrNJgxWTYMy+WXVAFt+p4qFO/Yw7E9WFM
	WkpyKrArIR8+j+iXyuQrZeeRz2M5axFyQ++nqETVYzOlTWJn3NIE/XchWyd2o4TdTYtKb0wlrcE
	xVqnP+CJlK6RLhF1yqbJQHgNQW+JJ/PZ1P+K0zqMjWcB26eOSERrXmRtpvqv+s+a69KqiUgc90N
	NDKhB2VAjwm8ezOeOWM/nsr5bq+UHwda/+NziW5kU728K6DZ9QwBwNYysfYoO+dnabPB3qXNDN5
	qekq8RIAzublOZ5ZUOew1cTOyDON9xTA9tbbQBE0zoKM+btxVlhy8OxJJ3AwVcWd9RpBhlr+Vqd
	k0yELd+90isiDR7GkiV5tGm/snwcnqsWUUxO7t0FpK6IQtOZzAc0LOytjxxkbwRfZrZDP48k6EO
	zKKzvwSGb7iB3UFJmvYzZsPzgf8G0LtWzj4l9/h61+RK/OFS2ycNvEcBQqwJ/RkvCAS3DwiDdl4
	J6HDe5jaTi6bTClj/eMMnSyFbf6NVyTX4+7o6WNiHJlTcQvykhxwWazF21lawBaXoy4bjRCzg==
X-Received: by 2002:a05:6000:240b:b0:43b:6127:2510 with SMTP id ffacd0b85a97d-43b88a0cb2fmr10393835f8f.42.1774512012165;
        Thu, 26 Mar 2026 01:00:12 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e352sm6284811f8f.3.2026.03.26.01.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:00:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:00:10 +0100
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Clear CLKREQ# override breaks functionality
Message-ID: <jfefktil6ywvugvbxdplbvry6g5efka5g4bpr2dwhha2mtrkm5@6gkcmj2glvwo>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard,

While integrating the `supports-clkreq` DT property on our iMX95-based
SoM, we had failures in our CI on one of the two M.2 PCIe slots on our
development board. 
The failing slot uses a card that does not advertise L1 PM substates.
This issue comes from commit a152a90f5390 ("PCI: imx6: Clear CLKREQ# 
override if 'supports-clkreq' DT property is available"), which clears
the CLKREQ# override based only on the DT property.

It seems that clearing the CLKREQ# override should happen only
when the driver knows that the downstream device advertises L1 PM 
Substates. Otherwise CLKREQ# should remain asserted to keep compatibility
with cards that do not support L1 PM Substates.

Thoughts?

Kind Regards

Franz
