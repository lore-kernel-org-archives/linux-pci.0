Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 31 Aug 2016 23:17:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Omer Khaliq <okhaliq@caviumnetworks.com>
Subject: Re: [PATCH v2 0/2] HWRNG/PCI: Add driver for Cavium Thunder RNG
Message-ID: <20160831151745.GA28366@gondor.apana.org.au>
References: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
MIME-Version: 1.0
In-Reply-To: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David.Daney@cavium.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ananth.Jasty@cavium.com,
 linux-crypto@vger.kernel.org, mpm@selenic.com, bhelgaas@google.com,
 clabbe.montjoie@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 04:27:13PM -0700, Omer Khaliq wrote:
> There is a hardware error rendering the FDL field incorrect for the some
> Thunder RNG devices. The first patch adds a PCI quirk to fix the problem.
> 
> The second patch adds the driver.
> 
> Changes from v1:
> 	Use PCI quirks as advised.
> 	Removed unecessary headers
> 	Format changes as advised

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
