Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 7 May 2018 15:43:49 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: pciehp: Add quirk for QDF2400 Command Completed
 erratum
Message-ID: <20180507124349.GC2879@lahna.fi.intel.com>
References: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: sulrich@codeaurora.org, Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Markus Elfring <elfring@users.sourceforge.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 06, 2018 at 06:30:53AM -0400, Sinan Kaya wrote:
> The QDF2400 controller does not set the Command Completed bit unless
> writes to the Slot Command register change "Control" bits.  Command
> Completed is never set for writes that only change software notification
> "Enable" bits.  This results in timeouts like this:
> 
> pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
