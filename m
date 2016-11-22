Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 1/2] PCI: iproc: fix 32-bit build
Date: Tue, 22 Nov 2016 22:13:54 +0100
Message-ID: <4393833.rTFctaL9Kd@wuerfel>
In-Reply-To: <e03e5c52-f321-916e-4650-c8bb271cd041@broadcom.com>
References: <20161122141844.1655574-1-arnd@arndb.de>
 <e03e5c52-f321-916e-4650-c8bb271cd041@broadcom.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Oza Oza <oza.oza@broadcom.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 22, 2016 9:42:05 AM CET Ray Jui wrote:
> 
> Hmmm, somehow we've never seen this link error for the ARM32 based
> platforms that we build for. Does it behave differently between
> different versions of compilers?
> 
> Nevertheless, this is a good change to take, thanks!

I looked at it again, and see now that it only happens with
a 64-bit RESOURCE_SIZE_T, which is only used on 32-bit
platforms with more than 4GB of memory addresses. It would
however show up in a multiplatform distro build for ARMv7VE,
so the fix is still clearly needed.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
