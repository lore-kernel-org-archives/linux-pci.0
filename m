Return-Path: <ndprkm@gmail.com>
MIME-Version: 1.0
From: Kallol Biswas <ndprkm@gmail.com>
Date: Tue, 13 Feb 2018 10:21:04 -0800
Message-ID: <CAP8qiGCNN4xgfDAtQf7H2rpBLJuLyWet0z6rau5WG7kVBj_NTg@mail.gmail.com>
Subject: enabling multiple MSI vectors for a DS port
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
            I am facing an interrupt generation issue when single MSI
is shared by both dpc and hotplug interrupt.

The DS port is multi-MSI capable. What I have noticed that if I move
the switch (with DS port) and OS disk to a different system multiple
MSI vectors are allocated and dpc isr and hotplug isr are on different
vectors.

It seems that BIOS controls allocation of MSI vectors. Is there anyway
to force linux kernel to allocate multiple vectors when port is
capable?

Regards,
Kallol
