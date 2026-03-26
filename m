Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBF402445
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540372; cv=none; b=Fkw+qG1NWgFYzu18Gmtb4ahESJUsv1kfI4mg3b64WGjG5Xqf9uXcJniuBjaP+FaShXYiHzkHwOaX0nU3+vLtaoI/MH3Czz7J8W8qO0/xN1Wbd1IO7Px9VIq8bXGyS5gKMqrn9iVwKKmqnZlWeUpsknOfEfXn1HF2WF+7bRmz9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540372; c=relaxed/simple;
	bh=JwITcv2kKeMkRaKZERaWtV5p1TZQoN4amNUvBQPTTtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUPe861QXjvj9WOKyUvuVhTZ14YVAS90m2TJ7f6wEmCkES65peJDy+N5LaT4HF1p2H4lTtn9VtWf5ympY6kA7tPRb+uvQgLvUE7Y8YtHl9DwjOvPdMsxtpGyL19AmWtA3paQNl3HIzlOUF27GYBbmRMhaBAXglS9DW0MBGBL9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf5jSWjs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf5jSWjs"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so693771f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774540369; x=1775145169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQ1hDzJlfrRklF9YY8ud/90bJ0SI0yIhi54T9lEnFo4=;
        b=gf5jSWjspEgc1/RCMSP6y2tH2LzO5eSbiJt3f5xMnJbi/dTUCEDRuIzMbnrf9LjQT8
         YXka86SfnqCfP6kY5XwyOl8FzglYosnPZMGpc4C7/5Lr1GRcyCJI9gFZMIXM/+dk8IWD
         cRyKx2a6t6zwf8L7Lyvvr2S4yPMvaG/TILYAESF/etfld4Hby8RbewvLJYUuQeOVPRB/
         kbQyedo17m7n8R8CQbbmMx1UGP05oMzeuqB3A9KqFw5/2mweSKhDuQPEHhzgph5TYpHm
         tUIkho+KXxv6K60m+hGMOOXw6lKqTg4b64OZ25FMHC3T3bLAevqD7F4HUv5s1nY7HFZ3
         kWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540369; x=1775145169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ1hDzJlfrRklF9YY8ud/90bJ0SI0yIhi54T9lEnFo4=;
        b=B0YcmVVbvadusQLT6ddWzsowxf/CGEJvLDLuPGcyzNtF9T18p1UP338m774pnmFH6T
         mR1Fc6LIOtVXJHgaF8lJQ1n6hyVp3K6bL89t1oR00geWNPxbdOvTx+E/70alcAwIrz4p
         52Kwt6fFu/2XQk2xwQmYCwMIYoQPucEO/enUkThcrPLLS2gu1q1EQxq8JT22xQM9yvx0
         dbPPThevaFl02kWW54bXIOrYTjQTd6oARpPNtby4A/ZXX+V+pdXgl3mUvhgnTPzr57s+
         aybQQzAizxCIOWu+tC0qnXvaITcNR4s9bHNbrebM6+xWd+hPtVTkclh4/WHJRYC9yjsV
         5y8g==
X-Forwarded-Encrypted: i=1; AJvYcCWrjdZXCq9NT994L2h0/U70vehjPoHcS9/x9vBtrsgS03QbaRZ1HWLK7ck31Vf2MZy8NIfHP3wChuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5h3FSffuBjP09WvtZr3wGfKjlPe6lE4VD72+e8KO/tRHV1T5
	JPV7KT/T5FvVuHjuOqk3XBDMbKl3mMxk5DuEI0zydtnQN2taZLKmcBAs
X-Gm-Gg: ATEYQzxKWACjIFsYZ0MVJbJT89MPR0YB/lY6EepwfC0DPU/eH6h2DmtVt/9UsoEUHKJ
	K8arTE5pwla9lUCGwtNzKGE7nDqJ2orAa2c7Ddc9ghOSqONAaPmhwYjn7I/78e1AuvlsbE2XceU
	Bm6nfRf/Z/q2xBab0LQSnm+tLDi0Fj3FgUOHnOy0CczgvbGb+r5Nnrn+sL/47+8W6c2CD7g1u3+
	KmHFW8uJPiuqSUvAhLs55vS0Dv1aqcEr2RD8DlI3cNFFkAVsxQpYZbjW+oTEw7Y4U/pKlFjukOt
	RtVqM30FnH33hnXXCfQ8IwpUwmoXcot5O5OP+GpZnd530hlUSCIPydjEZOxkDPhfEfofXuPw1Xq
	OSdni1iD5NHXrVr9xj7Jz8M29WW2qqm8RE4+9PpOUZsR/uK4fAkyCrIcejbp1FyGYhtnlbbO8Sy
	6bGyHBQlmk6sS7KyT/P506s3grDMuWyaRI1uU+m1YjR7N8tlYP/C08glKodH+dpG9vxzwhpo0lv
	FmWHPFXCMqgYJIsMxDspvvt6f4a6k4lYHy4ev5VH8oaE5s7FffSsWsPq3VNfzDdI/V2DubzEQ==
X-Received: by 2002:a05:6000:18a8:b0:43b:464a:28de with SMTP id ffacd0b85a97d-43b8899cdb7mr11877706f8f.14.1774540368645;
        Thu, 26 Mar 2026 08:52:48 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf5aesm9975594f8f.24.2026.03.26.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:52:48 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:52:47 +0100
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Manivannan Sadhasivam <mani@kernel.org>, Frank Li <frank.li@nxp.com>
Subject: Re: Clear CLKREQ# override breaks functionality
Message-ID: <35zryv5twyy5qzqlfyebnfqllm6xbosxn5h2qlkibvxqogmzix@svk73dvj4tf4>
References: <jfefktil6ywvugvbxdplbvry6g5efka5g4bpr2dwhha2mtrkm5@6gkcmj2glvwo>
 <AS8PR04MB8833063C53B769C0ACB086958C56A@AS8PR04MB8833.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833063C53B769C0ACB086958C56A@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Thu, Mar 26, 2026 at 08:17:29AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Franz Schnyder <fra.schnyder@gmail.com>
> > Sent: 2026年3月26日 16:00
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Franz Schnyder <franz.schnyder@toradex.com>;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; Francesco Dolcini
> > <francesco@dolcini.it>; Manivannan Sadhasivam <mani@kernel.org>; Frank
> > Li <frank.li@nxp.com>
> > Subject: Clear CLKREQ# override breaks functionality
> > 
> > Hi Richard,
> > 
> > While integrating the `supports-clkreq` DT property on our iMX95-based
> > SoM, we had failures in our CI on one of the two M.2 PCIe slots on our
> > development board.
> > The failing slot uses a card that does not advertise L1 PM substates.
> > This issue comes from commit a152a90f5390 ("PCI: imx6: Clear CLKREQ#
> > override if 'supports-clkreq' DT property is available"), which clears the
> > CLKREQ# override based only on the DT property.
> > 
> > It seems that clearing the CLKREQ# override should happen only when the
> > driver knows that the downstream device advertises L1 PM Substates.
> > Otherwise CLKREQ# should remain asserted to keep compatibility with cards
> > that do not support L1 PM Substates.
> > 
> > Thoughts?
> Hi Franz:
> No, CLKREQ# is not dependent on L1 PM Substates capabilities.
> 
> According to the PCI Express Card Electromechanical Specification r6.0,
> Section 2 (Auxiliary Signals):
> 
> "CLKREQ# (optional) signal is an open drain, active low signal that is driven
> low by the card to request that the PCI Express reference clock be available
> (active clock state) to allow the PCI Express interface to send/receive data."
> 
> When the 'supports-clkreq' property is present, it indicates that the endpoint
> device supports CLKREQ# signaling and will actively drive the signal low when
> it needs the reference clock.
> 
> Therefore, the RC (Root Complex) controller can safely clear any CLKREQ#
> active-low override settings, allowing the endpoint to control the clock
> request through proper CLKREQ# signaling.
> 
> If the endpoint devices on your platform can't drive the CLKREQ# signal to
> low, remove 'supports-clkreq' property from your board's device tree file.
> 
> Best Regards
> Richard Zhu
> > 
> > Kind Regards
> > 
> > Franz
Hi Richard,

Thanks for the explanation. I managed to find a PCIe specification, and
I can now see that my assumption was wrong. The L1 PM Substates mechanism
requires CLKREQ#, but not vice versa. To be safe with cards which lack
support, we'll just remove the 'supports-clkreq' property for now.

Kind regards

Franz
