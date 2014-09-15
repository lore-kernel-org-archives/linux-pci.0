Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1410748970.24738.3.camel@concordia>
Subject: Re: [PATCH v2 1/3] PCI/MSI/PPC: Remove arch_msi_check_device()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Date: Mon, 15 Sep 2014 12:42:50 +1000
In-Reply-To: <a7a806c4f531ba80386e9d0baf69571a827ea59c.1410078503.git.agordeev@redhat.com>
References: <cover.1410078503.git.agordeev@redhat.com>
	 <a7a806c4f531ba80386e9d0baf69571a827ea59c.1410078503.git.agordeev@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2014-09-07 at 20:57 +0200, Alexander Gordeev wrote:
> Moving MSI checks from arch_msi_check_device() function to
> arch_setup_msi_irqs() function makes code more compact and
> allows removing unnecessary hook arch_msi_check_device()
> from generic MSI code.
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>

I already acked the previous version, but if you didn't want it that's fine :)

cheers


