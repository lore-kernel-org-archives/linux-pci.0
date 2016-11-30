Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 30 Nov 2016 10:17:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] PCI: Add information about describing PCI in ACPI
Message-ID: <20161130161730.GB13411@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 Duc Dang <dhdang@apm.com>, lkml <linux-kernel@vger.kernel.org>,
 linaro-acpi@lists.linaro.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Lv Zheng <lv.zheng@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 29, 2016 at 03:39:11PM -0800, Linus Torvalds wrote:
> Bjorn, this email was marked as spam, because:
> 
>   It has a from address in google.com but has failed google.com's
> required tests for authentication
> 
> in particular, it looks like you used a non-google smtp server
> (kernel.org) to send the email, so there is no DKIM hash (or perhaps
> google just uses some other non-standard marker for "this actually
> came from google"). So gmail marks it as spam because dmarc fails:
> 
>        dmarc=fail (p=REJECT dis=NONE) header.from=google.com
> 
> Just to let you know. If you use your google.com email, you do need to
> go through the google smtp server.
> 
> This may or may not be new - I didn't go and look at old messages of
> yours, but it is possible that google.com enabled dmarc/dkim recently.

Argh, thanks for letting me know.  Looks like I've had this broken for a
long time, but I didn't notice.  I think I have it fixed so git will record
the author as bhelgaas@google.com, but git/stgit will send email from
helgaas@kernel.org via the kernel.org smtp server.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
