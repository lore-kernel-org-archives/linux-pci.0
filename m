Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794B40149E;
	Fri,  5 Jun 2026 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641468; cv=none; b=oJdUcZB1oZONLf0sllwD+m80+ll1SADPx5qpG9qbbUj0Xvl2iI7VFVtMQ2j7XVOxD1vIAHIQjNV5vZwovt0ZVSwHaTwOjWLGqlHIROKV/5IYXrDhMnosLunwVhL86dmjsijlTp8Dp9MpevDB/+UX4BtJ+6jhvz7Rt1962xwv7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641468; c=relaxed/simple;
	bh=2W2Z0yEsfvPID3nJ676bCZmV1HGOlnk9mb1VgflAgHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+9GqostZBGP5cGkW2lrZR96QpkQ7R8gV5Ojp1YYAHacsuBTH9hJ9UJNQIJQHFH0BDhLS3v2mlnHRSavijwGkh1sxufDno3v0rz6+qEJZtclOGZpSJZVamn6OM06fI8e9kfm83DLZfjuhEVwAAF2r+OXa72G6bdQ0Li8Jofgf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A8S9ZnVm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A8S9ZnVm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EE59E1A0904;
	Fri,  5 Jun 2026 06:37:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A96FA5FED1;
	Fri,  5 Jun 2026 06:37:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF958106A1F0D;
	Fri,  5 Jun 2026 08:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780641461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3IyHXE5kz/n0P8iPF96woiuOqliDOrQHxVfM4rBmin0=;
	b=A8S9ZnVmLHc2TeOD20ueswPQ2h9AH/Lrz65bcGqIXbWyNwoKK7UujEAsSt2UTcLUGo8PNU
	tMOy5+eoUJjOIgVsSo6uyjRAZRe0aSPu/mt9TSP/HuMLyvduncihLhub3KzDorbHAujJYb
	v8sdJGvdGucSBpMksUVdyjYe0TqG/IiyEQvzNurEKHor+U+yZue40FJ4FvMoEW3azUZvX7
	J14BjNow2/zRXmDln4ZOCxtaDhArmh5vJsFi3OaIAh3lg3jx7Qjy7hYIRiLikFr1JqiqdO
	vsYdhkhnBClMTF+v8u36hnu2bfhyFyZ0pvdOUq0MEg4wsY8rseJvmjgtv88rnw==
Date: Fri, 5 Jun 2026 08:37:31 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, Linus
 Walleij <linusw@kernel.org>, Len Brown <lenb@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
 <djbw@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>, Herve Codina
 <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 0/8] lan966x pci device: Add support for SFPs, PCI
 part
Message-ID: <20260605083731.1921f388@bootlin.com>
In-Reply-To: <20260511155930.34604-1-herve.codina@bootlin.com>
References: <20260511155930.34604-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Bjorn, all,

On Mon, 11 May 2026 17:59:20 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> Previously, I sent a big picture series adding support for SFP ports
> available on the LAN966x PCI device [0].
> 
> In this series patches touch several parts and sub-system in the kernel.
> Reviews have be done and it makes sense to split the series and send
> parts separately.
> 
> This current series is the extraction of patches related to issues in
> the PCI subsystem. It has to be seen as a continuation of the big
> picture series but related to this specific core part.
> 
> Patches 1 to 6 introduce and use fw_devlink_set_device() in already
> existing code. No functional change but the introduction of the
> fw_devlink_set_device() wrapper.
> 
> Patches 7 and 8 fix fw_devlink issues specific to PCI and the
> device-tree nodes created during enumeration.
> 
> [0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
> 
> Best regards,
> Hervé
> 

I haven't received any feedback on this series other than the
"Reviewed-by: Andy Shevchenko" tags.

IHMO, the series is ready to be applied. Do you have any comments ?

Best regards,
Hervé


