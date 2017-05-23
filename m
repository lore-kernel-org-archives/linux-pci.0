Return-Path: <SRS0=WrV6=45=gmail.com=piotrek.gregor@kernel.org>
Return-Path: <SRS0=WrV6=45=gmail.com=piotrek.gregor@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170523103904.3a20d0cc@w520.home>
References: <20170510122959.4uupohiz3ukzm4c4@debian1.home> <20170522233820.GH19733@bhelgaas-glaptop.roam.corp.google.com>
 <20170523161929.GA24431@bhelgaas-glaptop.roam.corp.google.com> <20170523103904.3a20d0cc@w520.home>
From: Piotr Gregor <piotrek.gregor@gmail.com>
Date: Tue, 23 May 2017 20:14:26 +0100
Message-ID: <CAO3obxb349aeDX1harujpzi_E2ZMq820wtjrODR5sYiZ=KtjwQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Handle the case when PCI_COMMAND register hasn't
 changed in INTx masking test
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Piotr Gregor <piotrgregor@rsyncme.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a114dad30377a41055035ce78"
List-ID: <linux-pci.vger.kernel.org>

--001a114dad30377a41055035ce78
Content-Type: text/plain; charset="UTF-8"

Would the pci_setup_device() be a good place to move this check to?

--001a114dad30377a41055035ce78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Would the=C2=A0pci_setup_device() be a good place to move =
this check to?</div>

--001a114dad30377a41055035ce78--
