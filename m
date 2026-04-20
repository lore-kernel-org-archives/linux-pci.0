Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231E13AA2F;
	Mon, 20 Apr 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677721; cv=none; b=mKIno91d/R+RFjdXKz+GF+9jy7xbZsekgdiv828KPKqXvcAT91T+GmeidzP7ldz7U5X3HVzaxVYIaeD7FYHHLfaH9cLQw7GOVV7RUerElWpQv9Tzv4wFIoAlDCQEkWs71opdyLQNHpp8mP4NgXMwXH5qBZbpv7zIaNFgBXDwaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677721; c=relaxed/simple;
	bh=ie4pHq24hX87Ox/y+xM4soh8D6peU7BX9IY2UXo6tvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8rJuJPzI+mdY8jTJablrzni6hRQx82E7/Mx3WKykvRPtAiLo9XFT8Ccfi5/vCf+Z7/mBBdsfBI1thKdZ2jJF4Qk0muNuDeBoQrDqPXMKL5nVgjv7Wo/NIFQdNvsiR8qM6gULmqaL/DKWZ98oY+iHJ7CE2rO28jG2R5Xhxr7mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV9s2VE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV9s2VE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C961C19425;
	Mon, 20 Apr 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776677720;
	bh=ie4pHq24hX87Ox/y+xM4soh8D6peU7BX9IY2UXo6tvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iV9s2VE7d9sBsBuzGHLRNE26Z22EnHXTiJ4oB0tzlYLUsoh7adXQjrGiO64itbhCZ
	 Om6gFOOYbUfzpwhvKwAkzv7SRRB8Bi+81ZYByhhaH8AiyYH/py4Wz+GULEuUIgdj44
	 WKkH3tlPvTs0mit1v59bSBi7j3dbvmgImK/GONTje2t5eucckT0rrUcSO35nDE25mN
	 8P/w+UqUlb9QyQApZK93jcQoxTEhKrhxyos1w7O81m/iWpXnxDYVP5nWiN5kmwEdts
	 /UndC8ta1PzkwWXmoCWTM6O14Hpsx9uqN8KQS69u+ON8rvUss13OSrJvZDwtFlfHsB
	 q5FIQySjmrYvw==
Date: Mon, 20 Apr 2026 15:05:06 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <nwoyko5feezkakwjjgwdbpwrlv7a3e72avux36t72uzp5mc2x7@26q7fnpvwupe>
References: <VI0PR04MB1211449884AC3BC8E3711F1AB92202@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <20260417195533.GA92707@bhelgaas>
 <viggqsxczf5d5hok4qpqhknalwb46xapsgdxbbgbqhruhyn2hn@wtck4yajmuw7>
 <VI0PR04MB12114304913B6AACF6A206E10922F2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114304913B6AACF6A206E10922F2@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Mon, Apr 20, 2026 at 08:24:57AM +0000, Sherry Sun wrote:

[...]

> > Even if there are PERST# GPIOs from the host, connected to downstream
> > ports of a PCIe switch, they could be stored in the Root Port's (pci_host_port)
> > struct as a list of PERST#. This is what pcie-qcom driver does.
> > 
> > It is too clumsy to handle PERST# individually for each device. We tried it
> > before with pwrctrl, but it always ended up biting us on who gets to control
> > the PERST#. We can't let pwrctrl handle PERST# for a switch port and host
> > controller driver handle it for RP. And we cannot let pwrctrl handle PERST# for
> > all ports, because, host controller drivers also need to control them for RC
> > initialization.
> > 
> > That's why it was decided to handle PERST# for all ports in the host controller
> > drivers. So following that pattern, this helper could also be extended to parse
> > the PERST# from all ports defined in DT and store them in the same Root Port
> > struct.
> > 
> > It should be trivial to implement this logic in the current helper. @Sherry:
> > Could you please implement this logic?
> 
> Hi Mani, do you mean the similar logic in this patch?
> https://lore.kernel.org/all/20251216-pci-pwrctrl-rework-v2-1-745a563b9be6@oss.qualcomm.com/
> If yes, of cause I can do this for current helper functions in pci-host-common.c.
> 

Yes!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
