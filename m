Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <a33cec72-e4ab-60cb-7173-41043f4a9120@redhat.com>
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
 <a33cec72-e4ab-60cb-7173-41043f4a9120@redhat.com>
From: Loc Ho <lho@apm.com>
Date: Wed, 31 May 2017 09:13:35 -0700
Message-ID: <CAPw-ZTnvCuwZ5ziZ+mVeZxwNiEKYFA+Qc7vUtP01XQ22Bnpd8Q@mail.gmail.com>
Subject: Re: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
To: jtoppins@redhat.com
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 Duc Dang <dhdang@apm.com>, "patches@apm.com" <patches@apm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Khuong Dinh <kdinh@apm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Mark Salter <msalter@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jon,

> > From: Khuong Dinh <kdinh@apm.com>
> >
> > This patch makes pci-xgene-msi driver ACPI-aware and provides
> > MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> >
> > Signed-off-by: Khuong Dinh <kdinh@apm.com>
> > Signed-off-by: Duc Dang <dhdang@apm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> > v2:
> >  - Verify with BIOS version 3.06.25 and 3.07.09
> > v1:
> >  - Initial version
>
>
> Hoping I just missed it, but was a follow-up (v3) ever provided for
> this? It seems this thread ended with the expectation that a v3 would be
> provided to address the sequencing issue.


No... You didn't missed anything. Khuong is out last couple days. He
is currently implementing the dependence requirement using the _DED
method. As soon as he get this working correctly, he will post the
next version. Though, there isn't anything wrong with the last version
besides future potential change in the kernel which is very unlikely
to change for the next one or more release of the future kernel.

-Loc

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
