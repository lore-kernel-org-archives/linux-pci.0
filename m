Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mason' <slash.tmp@free.fr>, linux-pci <linux-pci@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Subject: RE: Neophyte questions about PCIe
Date: Wed, 8 Mar 2017 14:38:00 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE7A879@AcuExch.aculab.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7A70A@AcuExch.aculab.com>
 <b735b894-4c6c-5eb0-524e-dccee648d0f8@free.fr>
In-Reply-To: <b735b894-4c6c-5eb0-524e-dccee648d0f8@free.fr>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Mason
> Sent: 08 March 2017 14:18
...
> > Don't think config space fits.
> > With the 'obvious' mapping the 'bus number' is in the top
> > 8 bits of the address.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> 
> 	cfg_offset(bus, device, function, register) =
> 		bus << 20 | device << 15 | function << 12 | register
> 
> 8 bits for bus, 5 bits for device, 3 bits for function, 12 bits for reg offset
> 1 MB per bus, 256 buses max => 256 MB max
> 
> Supporting "only" 64 buses is good enough, I believe.

I was comparing the PCIe TLP layout for config cycles and normal read/write.
There bus/dev/fun are in the top 16 bits with 4 reserved bits above the
register address (effectively allowing 64k of config space per function).

Possibly some logic shifting the address across for config cycles.

The TLP type also has a bit for type-0 v type-1 config cycles.
I can't quite remember the difference.

	David


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
