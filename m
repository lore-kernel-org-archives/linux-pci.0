Return-Path: <SRS0=4d9S=I6=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=4d9S=I6=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
References: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Jun 2018 15:08:53 -0700
Message-ID: <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.18, part 2
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, shawn.lin@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 12, 2018 at 2:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - squash AER directory into drivers/pci/pcie/aer.c (Bjorn Helgaas)

Could we please see *reasons* for this series of commits?

Those commit messages have trivial "what", but no explanations "why".

                  Linus
