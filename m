Return-Path: <SRS0=K+lw=BB=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=K+lw=BB=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        Linuxarm
	<linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liudongdong (C)" <liudongdong3@huawei.com>
Subject: RE: [PATCH v3] PCIe AER: report uncorrectable errors only to the
 functions that logged the errors
Date: Mon, 2 Oct 2017 10:20:37 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40C4D91D@FRAEML521-MBX.china.huawei.com>
References: <1506609185-8800-1-git-send-email-gabriele.paoloni@huawei.com>
 <20170929211526.GD31210@bhelgaas-glaptop.roam.corp.google.com>
 <20170929213102.GE31210@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170929213102.GE31210@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

[...]

> >
> > Applied to pci/aer for v4.15, thanks!
> >
> > I rewrote some of the changelog to say "non-fatal" instead of
> > "uncorrectable", since "uncorrectable" also includes fatal errors,
> > and you're not changing those.  Take a look and let me know if
> > I broke anything.
>=20
> Here it is so you don't have to look it up :)
>=20

Many thanks Bjorn!

Gab

[...]
