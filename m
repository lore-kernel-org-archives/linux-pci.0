Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
	<20120307223255.25669.42520.stgit@bhelgaas.mtv.corp.google.com>
Date: Wed, 7 Mar 2012 14:35:29 -0800
Message-ID: <CAOesGMiPJg1gbsq_iBc6_6JrOtTonSoic-gGudBNpmz2BEHv8g@mail.gmail.com>
Subject: Re: [PATCH v3 10/34] powerpc/PCI: allow reallocation on PA Semi
From: Olof Johansson <olof@lixom.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 7, 2012 at 2:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> We believe there's no reason to prevent reallocation on PA Semi, so
> revert to the default of "allow reallocation if necessary."
>
> CC: Olof Johansson <olof@lixom.net>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Olof Johansson <olof@lixom.net>
Acked-by: Olof Johansson <olof@lixom.net>
