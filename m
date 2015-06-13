Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 13 Jun 2015 23:42:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Julia Lawall <julia.lawall@lip6.fr>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC v1 14/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <alpine.DEB.2.11.1506132230450.3786@nanos>
Message-ID: <alpine.DEB.2.02.1506132337110.2020@localhost6.localdomain6>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos>
 <alpine.DEB.2.10.1506131059180.2486@hadrien> <alpine.DEB.2.11.1506131130490.3786@nanos> <alpine.DEB.2.10.1506131603151.2314@hadrien> <alpine.DEB.2.10.1506131652380.2314@hadrien> <557C5F29.7010301@linux.intel.com> <alpine.DEB.2.02.1506132214310.2020@localhost6.localdomain6>
 <alpine.DEB.2.11.1506132230450.3786@nanos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The semantic patch below considers the problem from another point of view, 
to find functions that may have a handler as an argument.  The results 
that are different than those considered already are as follows:

arch/x86/platform/uv/uv_irq.c:106 irq_domain_set_info
	has a possible handler in argument 6
arch/sparc/kernel/leon_pci_grpci2.c:815 leon_update_virq_handling
	has a possible handler in argument 2
arch/sparc/kernel/leon_kernel.c:79 leon_build_device_irq
	has a possible handler in argument 2
arch/arm/mach-omap2/prm_common.c:331 irq_alloc_generic_chip
	has a possible handler in argument 5
arch/mips/cavium-octeon/octeon-irq.c:1231 octeon_irq_set_ciu_mapping
	has a possible handler in argument 6
arch/blackfin/mach-common/ints-priority.c:805 bfin_set_irq_handler
	has a possible handler in argument 2
arch/m68k/q40/q40ints.c:84 m68k_setup_irq_controller
	has a possible handler in argument 2
drivers/gpio/gpio-pcf857x.c:362 gpiochip_irqchip_add
	has a possible handler in argument 4

The semantic patch looks for a function that has as argument a function 
that has arguments of type (unsigned int irq, struct irq_desc *desc) and a 
void return type.  It also looks for functions that have as argument a 
bunch of known irq handlers.

julia


@initialize:ocaml@
@@
let tbl = Hashtbl.create 101
let ln = Str.regexp "linux-next/" (* update as appropriate *)

let _ =
  List.iter (function x -> Hashtbl.add tbl x ())
    [("__irq_set_handler",2);("irq_set_handler",2);
      ("irq_set_chained_handler",2);("irq_alloc_generic_chip",4);
      ("irq_alloc_domain_generic_chips",5);("irq_set_chip_and_handler_name",3);
      ("irq_set_chip_and_handler",3);("__irq_set_handler_locked",2);
      ("__irq_set_chip_handler_name_locked",3);("__irq_set_preflow_handler",2);
      ("gpiochip_set_chained_irqchip",4)]

let update g f n p =
  let n = n + 1 in
  let entry = (g,n) in
  try let _ = Hashtbl.find tbl entry in ()
  with Not_found ->
    begin
      Hashtbl.add tbl entry ();
      let p = List.hd p in
      Printf.printf "%s:%d %s\n\thas a possible handler in argument %d\n"
	(List.nth (Str.split ln p.file) 1) p.line g
	n
    end

@possible_handler@
identifier f,irq,desc;
@@

void f(unsigned int irq, struct irq_desc *desc) { ... }

@call@
identifier g,possible_handler.f;
expression list[n] es;
position p;
@@

g(es,f@p,...)

@script:ocaml@
p << call.p;
f << possible_handler.f;
g << call.g;
n << call.n;
@@

update g f n p

@call2@
identifier g,f;
expression list[n] es;
position p;
symbol handle_level_irq,handle_simple_irq,handle_edge_irq,
       handle_fasteoi_irq,handle_percpu_irq;
@@

g(es,\(handle_level_irq@f@p\|handle_simple_irq@f@p\|handle_edge_irq@f@p\|
       handle_fasteoi_irq@f@p\|handle_percpu_irq@f@p\),...)

@script:ocaml@
p << call2.p;
f << call2.f;
g << call2.g;
n << call2.n;
@@

update g f n p
