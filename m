Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294339A7EF
	for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786791895; cv=none; b=hIJyrTDGGORBoEX2poQYLdQZqeEY2LfOXW6hLuZ5/IbcRK/RtabP1hHJ0nlxfyT7BMDrQfmfAuGQcUc2CvlTd4SXfUtWB24LYYHDq7DqBG7zUV6XDjnAJGFjN811NKgKdrhTRWSOMeHVoA/Ag1gULU+WxkCG56fwOOlvwAu8y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786791895; c=relaxed/simple;
	bh=PIwtDxPNXPwuqN/MMgPlIbl3Hk8FZM9bPABxqr3+O4Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9VeYLevJ3ruWCYplGqAzIBtRZCXFELn9k+dwLuUzbH+IjohmfNy3/g5wPTzWSVXi+ixXkSftjfMu1NN820PH8D7rryprLS9wmwOhDVx6zv8A6MMkMg6cdkmCgkGouiWuzaEevul+0voJMDis/ChWQRhiYvhTblVpVJDvHtFqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA2CM4hQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA2CM4hQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f633e6058so1675319f8f.0
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786791891; x=1787396691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GrwB5zfsW4lC1jK6YCZThBFVhJVN5/++tlnL9AR3ZH4=;
        b=UA2CM4hQHaIqHZ83+0c9yQ7Rv8tu47Epg/0+/E4csrxAppIOwIB/zc9GrWDnBwUtd/
         /E5c7Xo3BQAgKcc8nH7Qdkj4uebRjgEXe1CO+SQs0+HVxnjMB0VLDj1ITLx7psb3uGDn
         xszXqdjqOVe4srzXCXPBegTUbD8sktF1xVwF7kY1ZfFe6lTO3a+iHtVcRBDJzyNsO0i6
         nGRqGesxsABDwt8/yznYkhG6b/Whhi+sTewyl5nYiIs0UFM8t/5UTgbQwGwfx4cCmGCH
         7erdWnoy/5VQ5gPTBKrtOeMGT4A9GjY5X1KhcdwH7pgti9yL9QujoDZPxUTVJUlwMYCg
         0Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786791891; x=1787396691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrwB5zfsW4lC1jK6YCZThBFVhJVN5/++tlnL9AR3ZH4=;
        b=n0NwP+sUkRrnjDy7sfLCskZAgOSY7/NttzUWEg3MFZaO5kU4wCA0svjcyHjTG0UKNt
         0hTFjgdsjdGRxvmOClc8HP6WzJ7um4te/G3Hml1ZJLY7pUjZxOq4d3FzQv2PT+Yh+3y4
         7YLLSRd4OU3YE9lOY3Kt7R6bgTjDl9o1j2iMJX/ziR44YZtA8bmBQ8OqNQ7Gn20P0TSp
         qacNW4XoeXeFmOlPPr8DaqotdIZoWTgqAarynGK4mMfMAwyUFGC/dZZquFi0yxY15iUq
         IspB6rOMZgB7Gl86UFgR57C23mPvwnSEns7oeCvGro5bh215hDPlGayOm6xHLJB/QhO1
         2wmw==
X-Forwarded-Encrypted: i=1; AHgh+Rre+CryiT5IfxOOvRTKH4Qm3/z5v7tNm6iR6ItKUjWknjIzYSaPGGugoo1NxTXSmZh1yz/3tfGHqxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZ6kvmGqxXw36noauM/F136wa6/ibi4GnlD3MtK29ZBuv2k5R
	6AFgyYw+lC8Ns7ytlpty6nLu5u/v43VgnN6T/knv51yDdd+iC7l+EmhY
X-Gm-Gg: AR+sD11+O5oN15dDUNmKroiv45ldbJXaHKXdf8CekZIggC14AkkWnC5qcyJIQiBBa0X
	AY1NJYXT8j3SUIKjb89auZTzr4rpHA6rQV8UbSN1AmYBjhxjbEDGGm6Rpn5oPsrN6cLOSjV+lWY
	0CubuzjvvUOS1x98q0e7CytD70ROfnqmmPS2PseoO4VgfaI1RuyAbF/0vxZOsgCoySjUycydm0O
	uOzhb5blr1ESqdbcvhF7sXR7jih386MuMsi25U/lbZ7n2MlatE5oipkYuDgfhn4yMwdxQ2SIMhv
	Ump11ieRSF9ggaIraaSRNoiyBPq8DXd/9SEc8tW6xpUzmU4yc1lFfBrYO6GLSsquvrdT7kHxRXf
	ZZFHrPOOUk/EjA+V6DJl75hqcQjb0NqWDa0FvzkZ86mF5JXZ+GR98lPNUL7YnOFNaNrFJyd12Cx
	j9aiXd85FhES5b4lz80scY33wLijYVz/RxiINhwITdh1Twnj+6IiM2eBJrovTuINAsgDhOPo0/c
	yRrP+ZcIlmDOCFEZKxus85A+5fZcDs=
X-Received: by 2002:a05:600c:1f91:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4998797d111mr154059175e9.15.1786791890869;
        Sat, 15 Aug 2026 04:04:50 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899afae3sm98004825e9.3.2026.08.15.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:04:49 -0700 (PDT)
Message-ID: <6a8047d1.3527643f.2d620e.3236@mx.google.com>
X-Google-Original-Message-ID: <aoBHzVNCc-TOnCaP@Ansuel-XPS.>
Date: Sat, 15 Aug 2026 13:04:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] PCI: mediatek-gen3: Add 2-lanes mode support for
 Airoha AN7581
References: <20260806165334.7328-3-ansuelsmth@gmail.com>
 <20260813170820.GA1143871@bhelgaas>
 <6a7e1b73.e11288f4.1351ae.5625@mx.google.com>
 <5qulrgfnwzuo556hxsyg3iweqv6i57ll3chhhb3nxe7lgr6fff@4l3s5rotnpab>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5qulrgfnwzuo556hxsyg3iweqv6i57ll3chhhb3nxe7lgr6fff@4l3s5rotnpab>

On Sat, Aug 15, 2026 at 08:16:56AM +0200, Manivannan Sadhasivam wrote:
> On Thu, Aug 13, 2026 at 09:30:54PM +0200, Christian Marangi wrote:
> > On Thu, Aug 13, 2026 at 12:08:20PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Aug 06, 2026 at 06:53:32PM +0200, Christian Marangi wrote:
> > > > The Airoha AN7581 SoC supports configuring the first PCIe0 lane to 2-lanes
> > > > mode (x2 link) by bonding it with the second PCIe lane (PCIe1). This is
> > > > done by configuring the PCIe MUX in the SCU register.
> > > > 
> > > > To correctly configure PCIe0 in x2 link, define in DT the following
> > > > additional properties:
> > > > 
> > > >   - additional reg, 'sec-pcie-mac' for the secondary PCIe.
> > > >   - PERSTOUT reset for both main and secondary PCIE0, called 'perstout' and
> > > >     'sec-perstout'
> > > >   - 'airoha,scu' property to correctly configure the SCU register for the
> > > >     PCIe MUX
> > > >   - 'num-lanes' set to '2' to enable PCIe0 in x2 link
> > > > 
> > > > In such configuration the EQ preset are configured to the same values.
> > > > 
> > > > To permit correct configuration of the PCIe link, additional logic is added
> > > > to assert and deassert the PERSTOUT resets. Support of these additional
> > > > reset was introduced in Airoha clk driver with commit
> > > > 6712f48eb3a1 ("clk: en7523: add support for dedicated PCIe PERSTOUT reset")
> > > > and on backporting of this commit also the clk driver change will be
> > > > needed.
> > > 
> > > I don't see 6712f48eb3a1 in upstream or linux-next.  Is this SHA1
> > > going to valid if we merge this for v7.3?
> > 
> > I picked that sha1 from the git pull for the staging clk tree.
> > 
> 
> Ah, I missed it. In this case the SHA should be dropped and maybe we can refer
> the lore link of the patch?
> 

Just yesterday it was picked and it's present in clk-next [1].

The commit didn't change as merge commit are used so the sha1 is valid.

I think we can keep it?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/drivers/clk/clk-en7523.c?h=clk-next&id=6712f48eb3a15842925171441505fa2e7699c57e

-- 
	Ansuel
